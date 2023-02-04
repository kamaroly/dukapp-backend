defmodule Butike.Backup do
	
	@moduledoc """
	The Backup Context 
	"""

	import Ecto.Query
	alias Butike.Repo

	alias Butike.Backup.Order

	@doc """
	Backups an order
	"""
	def order(order) do
		
		order = %Order{
			phone_number: order["shop_msisdn"],
			order_type: "sale",
			quantity: 1.9
		}

		Repo.insert!(order)
	end

	@doc """
	Returns the list of orders 

	## Examples

		iex> list_orders()
		[%Order{}, ...]

	"""
	def list_orders() do
		Repo.all(Order)
	end
end