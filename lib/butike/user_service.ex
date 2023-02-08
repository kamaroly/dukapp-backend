defmodule Butike.UserService do
  alias Butike.Users.User
  alias Butike.Repo

  @spec create_by_phone(any) :: any
  def create_by_phone(phone) do
    Repo.insert(%User{
      shop_phone: phone
    })
  end
end
