defmodule Butike.UserService do
  alias Butike.Users.User
  alias Butike.Repo

  @spec create_by_phone(any) :: any
  def create_by_phone(phone) do
    Repo.insert(%User{
      shop_phone: phone,
      otp: Integer.to_string(Enum.random(1000..9999))
    })
  end
end
