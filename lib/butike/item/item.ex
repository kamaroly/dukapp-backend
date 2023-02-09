defmodule Butike.Item.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :category, :string
    field :cost_price, :integer
    field :description, :string
    field :is_service, :integer
    field :meta_data, :string
    field :name, :string
    field :note, :string
    field :quantity, :integer
    field :reorder_level, :integer
    field :sale_price, :integer
    field :shop_item_id, :integer
    field :shop_msisdn, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:shop_msisdn, :shop_item_id, :name, :description, :category, :reorder_level, :quantity, :cost_price, :sale_price, :is_service, :note, :meta_data])
    |> validate_required([:shop_msisdn, :shop_item_id, :name, :description, :category, :reorder_level, :quantity, :cost_price, :sale_price, :is_service, :note, :meta_data])
  end
end
