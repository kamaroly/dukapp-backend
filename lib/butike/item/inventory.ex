defmodule Butike.Item.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_inventories" do
    field :amount, :float
    field :comment, :string
    field :item_id, :integer
    field :quantity, :float
    field :shop_msisdn, :string

    timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:shop_msisdn, :item_id, :comment, :quantity, :amount])
    |> validate_required([:shop_msisdn, :item_id, :comment, :quantity, :amount])
  end
end
