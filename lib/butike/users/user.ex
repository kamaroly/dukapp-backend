defmodule Butike.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Butike.Order.Order
  alias Butike.Order.OrderItem
  alias Butike.Customer.Customer
  alias Butike.Item.Item
  alias Butike.Item.Inventory
  alias Butike.Supplier.Supplier

  @derive {Jason.Encoder,
           only: [
             :shop_phone,
             :name,
             :inserted_at,
             :updated_at,
             :orders,
             :order_items,
             :items,
             :item_inventories,
             :customers,
             :suppliers
           ]}

  schema "users" do
    field :shop_phone, :string
    field :name, :string
    field :otp, :string
    field :otp_expires_at, :string

    timestamps()

    has_many :orders, Order, foreign_key: :shop_msisdn, references: :shop_phone
    has_many :order_items, OrderItem, foreign_key: :shop_msisdn, references: :shop_phone
    has_many :items, Item, foreign_key: :shop_msisdn, references: :shop_phone
    has_many :item_inventories, Inventory, foreign_key: :shop_msisdn, references: :shop_phone
    has_many :customers, Customer, foreign_key: :shop_msisdn, references: :shop_phone
    has_many :suppliers, Supplier, foreign_key: :shop_msisdn, references: :shop_phone
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [
      :shop_phone,
      :otp,
      :otp_expires_at
    ])
    |> validate_required(:shop_phone)
    |> unique_constraint(:shop_phone, name: :unique_shop_phone_index)
  end
end
