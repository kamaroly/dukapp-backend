defmodule Butike.Backup.Order do
	use Ecto.Schema 

	@derive {Jason.Encoder, only: [:shop_msisdn, :order_type, :quantity]}

	schema "orders" do
		field :shop_msisdn, :string
		field :order_type, :string
		field :item_id, :integer, default: 0
		field :item_name, :string
		field :item_description, :string
		field :customer_or_supplier_id, :integer
		field :quantity, :decimal
		field :cost_price, :decimal
		field :sale_price, :decimal
		field :payment_mode, :string
		field :created_at, :naive_datetime
		field :updated_at, :naive_datetime
		field :deleted_at, :naive_datetime
	end
end