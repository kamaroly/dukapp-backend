defmodule Butike.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def up do

    create table("orders") do 
      add :shop_msisdn, :string, null: false, size: 15
      add :order_type, :string, null: false
      add :item_id, :integer, null: false
      add :item_name, :string, null: false
      add :item_description, :string, null: false
      add :customer_or_supplier_id, :integer, null: false
      add :quantity, :decimal, default: 0
      add :cost_price, :decimal, default: 0
      add :sale_price, :decimal, default: 0
      add :payment_mode, :string, null: false
      add :created_at, :naive_datetime, default: fragment("NOW()")
      add :updated_at, :naive_datetime, default: fragment("NOW()")
      add :deleted_at, :naive_datetime

    end
  end

  def down do
    drop table("orders")
  end
end
