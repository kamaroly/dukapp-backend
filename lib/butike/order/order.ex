defmodule Butike.Order.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :coupon_lines, :string
    field :created_via, :string
    field :customer_supplier_id, :integer
    field :customer_supplier_note, :string
    field :discount_tax, :float
    field :discount_total, :float
    field :fee_lines, :string
    field :meta_data, :string
    field :note, :string
    field :order_key, :string
    field :order_type, :string
    field :payments, :string
    field :prices_include_tax, :integer
    field :refunds, :string
    field :shop_msisdn, :string
    field :shop_order_id, :integer
    field :status, :string
    field :tax_lines, :string
    field :total, :float
    field :total_tax, :float
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:shop_msisdn, :shop_order_id, :order_type, :order_key, :created_via, :version, :status, :discount_total, :discount_tax, :total, :total_tax, :prices_include_tax, :customer_supplier_id, :customer_supplier_note, :payments, :tax_lines, :coupon_lines, :fee_lines, :refunds, :note, :meta_data])
    |> validate_required([:shop_msisdn, :shop_order_id, :order_type, :order_key, :created_via, :version, :status, :discount_total, :discount_tax, :total, :total_tax, :prices_include_tax, :customer_supplier_id, :customer_supplier_note, :payments, :tax_lines, :coupon_lines, :fee_lines, :refunds, :note, :meta_data])
  end
end
