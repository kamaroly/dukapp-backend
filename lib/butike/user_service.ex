defmodule Butike.UserService do
  import Ecto.Query

  alias Butike.Repo
  alias Butike.Users.User
  alias Butike.Helpers.StringHelper
  alias Butike.SmsService

  @spec create_by_phone(any) :: any
  def create_by_phone(phone) do
    # Generate a random OTP for this number and user
    otp_number = Integer.to_string(Enum.random(100_000..999_999))

    sms_message =
      "Your DUKAPP One Time Password(OTP) is \n\n " <>
        otp_number <> "  \n\nValid for 2 minutes. Sent with Love."

    register_user_by_phone(phone, otp_number)
    SmsService.send(phone, sms_message)
  end

  def register_user_by_phone(phone, otp_number) do
    {:ok, otp_will_expire_at} =
      Timex.shift(Timex.now(), minutes: 2) |> Timex.format("{YYYY}-{0M}-{0D}T{h24}:{m}:{s}")

    Repo.insert(%User{
      shop_phone: phone,
      otp: StringHelper.hash_md5(otp_number),
      otp_expires_at: otp_will_expire_at
    })
  end

  def is_otp_valid(phone, otp_code) do
    hashed_otp_code = StringHelper.hash_md5(otp_code)

    {:ok, current_date_time} = Timex.now() |> Timex.format("{YYYY}-{0M}-{0D}T{h24}:{m}:{s}")

    result =
      Repo.all(
        from user in User,
          where:
            user.shop_phone == ^phone and user.otp == ^hashed_otp_code and
              user.otp_expires_at > ^current_date_time
      )

    Enum.count(result) > 0
  end
end
