defmodule Butike.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :shop_msisdn, :string
      add :shop_supplier_id, :integer
      add :company_name, :text
      add :phone, :text
      add :email, :text
      add :tin, :text
      add :address, :text
      add :note, :text
      add :meta_data, :text

      timestamps(default: fragment("CURRENT_TIMESTAMP"))

    end
  end
end
