defmodule Butike.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :shop_msisdn, :string
      add :name, :text
      add :item_id, :integer
      add :order_id, :integer
      add :description, :text
      add :variation_id, :integer
      add :quantity, :integer
      add :unit_cost_price, :integer
      add :unit_sales_price, :integer
      add :total, :float
      add :taxes, :text
      add :note, :text
      add :meta_data, :text

      timestamps()
    end
  end
end
