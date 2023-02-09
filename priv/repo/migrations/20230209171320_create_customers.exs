defmodule Butike.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :shop_msisdn, :string
      add :shop_customer_id, :integer
      add :names, :text
      add :phone, :text
      add :email, :text
      add :address, :text
      add :note, :text
      add :meta_data, :text

      timestamps()
    end
  end
end
