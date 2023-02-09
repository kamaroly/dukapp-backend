defmodule Butike.Order.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :description, :string
    field :item_id, :integer
    field :meta_data, :string
    field :name, :string
    field :note, :string
    field :order_id, :integer
    field :quantity, :integer
    field :shop_msisdn, :string
    field :taxes, :string
    field :total, :float
    field :unit_cost_price, :integer
    field :unit_sales_price, :integer
    field :variation_id, :integer

    timestamps()
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:shop_msisdn, :name, :item_id, :order_id, :description, :variation_id, :quantity, :unit_cost_price, :unit_sales_price, :total, :taxes, :note, :meta_data])
    |> validate_required([:shop_msisdn, :name, :item_id, :order_id, :description, :variation_id, :quantity, :unit_cost_price, :unit_sales_price, :total, :taxes, :note, :meta_data])
  end
end
