defmodule Butike.Supplier.Supplier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suppliers" do
    field :address, :string
    field :company_name, :string
    field :email, :string
    field :meta_data, :string
    field :note, :string
    field :phone, :string
    field :shop_msisdn, :string
    field :shop_supplier_id, :integer
    field :tin, :string

    timestamps()
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:shop_msisdn, :shop_supplier_id, :company_name, :phone, :email, :tin, :address, :note, :meta_data])
    |> validate_required([:shop_msisdn, :shop_supplier_id, :company_name, :phone, :email, :tin, :address, :note, :meta_data])
  end
end
