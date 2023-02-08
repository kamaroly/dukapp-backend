defmodule Butike.Users.User do
  use Ecto.Schema

  schema "users" do
    field :shop_phone, :string
    field :name, :string
    field :otp, :string
    field :otp_expires_at, :naive_datetime
    field :created_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
