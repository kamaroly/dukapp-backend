defmodule Butike.Customer.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :address,
             :email,
             :meta_data,
             :names,
             :note,
             :phone,
             :shop_customer_id,
             :shop_msisdn,
             :inserted_at,
             :updated_at
           ]}
  schema "customers" do
    field :address, :string
    field :email, :string
    field :meta_data, :string
    field :names, :string
    field :note, :string
    field :phone, :string
    field :shop_customer_id, :integer
    field :shop_msisdn, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :shop_msisdn,
      :shop_customer_id,
      :names,
      :phone,
      :email,
      :address,
      :note,
      :meta_data
    ])
    |> validate_required([
      :shop_msisdn,
      :shop_customer_id,
      :names,
      :phone,
      :email,
      :address,
      :note,
      :meta_data
    ])
  end
end
