defmodule Butike.Backup do
	
	@moduledoc """
	The Backup Context 
	"""
	import Ecto.Query
	alias Butike.Repo
	alias Ecto.Adapters.SQL
	alias Butike.Backup.Order
	@doc """
	Backups an order
	"""
	def order(attributes) do

		# Query parameters: "254757161010,sale, 1.72"
		parameters = String.split(attributes["query_parameters"], ",")
		query_string  = attributes["query_string"] 

		Ecto.Adapters.SQL.query(Repo, query_string, parameters)
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