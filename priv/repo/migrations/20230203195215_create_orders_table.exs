defmodule Butike.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def up do

    create table("orders") do 
      add :phone_number, :string, null: false, size: 15
      add :order_type, :string, null: false
      add :quantity, :float
      # add :item_id, :string, null: false
      # add :item_name, :string, null: false
      # add :item_description, :string, null: false
      # add :customer_or_supplier_id, :string, null: false
      # add :quantity, :decimal
      # add :cost_price, :decimal
      # add :sale_price, :decimal
      # add :payment_mode, :string, null: false
      # add :created_at, :utc_datetime
      # add :updated_at, :utc_datetime
      # add :deleted_at, :utc_datetime

    end
  end

  def down do
    drop table("orders")
  end
end
