defmodule ButikeWeb.Api.BackupController do
	use ButikeWeb, :controller
	alias Butike.Backup
	alias Butike.Repo

	@doc """
	Returns the list of orders collection

	"""
	def orders(conn, _params) do
	    orders = Backup.get_orders(Order)

	    render(conn, "index.json", orders: orders)
	end


	def real_time(conn, params) do
		
		#1. Insert into the database
		attributes = %{"shop_msisdn" => shop_msisdn, "resource" => resource, "action" => action, "columns" => columns, "values" => values} = params
		order = Backup.order(attributes)

		#2. Construct the response
		response = %{
			"code" => 201,
			"status" => "success",
			"message" => "Real time backup taken"
		}		

		json(conn, response)
	end
end