defmodule Butike.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:shop_phone, :string, nil: false)
      add(:name, :string)
      add(:otp, :string)
      add(:otp_expires_at, :string)

      timestamps(default: fragment("NOW()"))
    end
  end
end
