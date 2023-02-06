defmodule Butike.Backup do
	
	@moduledoc """
	The Backup Context 
	"""
	import Ecto.Query
	alias Butike.Repo
	alias Ecto.Adapters.SQL
	alias Butike.Backup.Order
	alias Butike.Helpers.StringHelper


	@doc """
	Backups an order
	"""
	def record(attributes) do

		# query_values = attributes["query_parameters"]
		parameters = String.split(attributes["query_parameters"], ",")
					 # Parse all integer
					 |> Enum.map(fn value -> StringHelper.to_number(value) end)

		query =  attributes["query_string"]

		IO.inspect query 
		IO.inspect parameters
		SQL.query!(Repo, query, parameters)
	end



	@doc """
	Returns the list of orders 

	## Examples

		iex> list_orders()
		[%Order{}, ...]

	"""
	def list_orders() do
		Repo.all(from order in Order)
	end
end