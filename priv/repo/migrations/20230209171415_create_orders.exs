defmodule Butike.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :shop_msisdn, :string
      add :shop_order_id, :integer
      add :order_type, :string
      add :order_key, :string
      add :created_via, :string
      add :version, :string
      add :status, :string
      add :discount_total, :float
      add :discount_tax, :float
      add :total, :float
      add :total_tax, :float
      add :prices_include_tax, :integer
      add :customer_supplier_id, :integer
      add :customer_supplier_note, :text
      add :payments, :text
      add :tax_lines, :text
      add :coupon_lines, :text
      add :fee_lines, :text
      add :refunds, :text
      add :note, :text
      add :meta_data, :text

      timestamps(default: fragment("CURRENT_TIMESTAMP"))
    end
  end
end
