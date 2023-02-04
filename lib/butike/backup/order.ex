defmodule Butike.Backup.Order do
	use Ecto.Schema 

	@derive {Jason.Encoder, only: [:phone_number, :order_type, :quantity]}

	schema "orders" do
		field :phone_number, :string
		field :order_type, :string
		field :quantity, :float
		# field :item_id, :integer, default: 0
		# field :item_name, :string
		# field :item_description, :string
		# field :customer_or_supplier_id, :string
		# field :quantity, :decimal
		# field :cost_price, :decimal
		# field :sale_price, :decimal
		# field :payment_mode, :string
		# field :created_at, :utc_datetime
		# field :updated_at, :utc_datetime
		# field :deleted_at, :utc_datetime
	end
end