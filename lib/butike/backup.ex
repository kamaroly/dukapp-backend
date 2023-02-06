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
	def record(attributes) do

		# query_values = attributes["query_parameters"]
		parameters = String.split(attributes["query_parameters"], ",")
		query = attributes["query_string"] 

		Ecto.Adapters.SQL.query(Repo, query, parameters)
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