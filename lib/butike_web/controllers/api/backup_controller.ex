defmodule ButikeWeb.Api.BackupController do
	use ButikeWeb, :controller
	alias Butike.Backup.Order
	alias Butike.Repo


	def index(conn, _params) do
		
	    # orders = [%{title: "foo"}, %{title: "bar"}]

	    orders = Repo.all(Order)

	    render(conn, "index.json", orders: orders)
	end
end