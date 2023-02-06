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


		string_to_integer = fn int_string -> 
						 	Integer.parse(int_string)
						 	|> case do 
						 		{int, ""} -> 

						 			if String.length(Integer.to_string(int)) < 7 do
						 				int
						 			else
						 				int_string
						 			end
						 		_ -> int_string
						 	end
						end

		# query_values = attributes["query_parameters"]
		parameters = String.split(attributes["query_parameters"], ",")

					 # Parse all integer
					 |> Enum.map(string_to_integer)

		IO.inspect(parameters)

		# query =  attributes["query_string"]
		# Ecto.Adapters.SQL.query!(Repo, query, parameters)
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