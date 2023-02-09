defmodule Butike.Repo.Migrations.CreateItemInventories do
  use Ecto.Migration

  def change do
    create table(:item_inventories) do
      add :shop_msisdn, :string
      add :item_id, :integer
      add :comment, :text
      add :quantity, :float
      add :amount, :float

      timestamps()
    end
  end
end
