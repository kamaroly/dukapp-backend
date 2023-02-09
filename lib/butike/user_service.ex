defmodule Butike.UserService do
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

    Repo.insert(%User{
      shop_phone: phone,
      otp: StringHelper.hash_md5(otp_number)
    })

    SmsService.send(phone, sms_message)
  end
end
