defmodule ButikeWeb.Api.BackupController do
  use ButikeWeb, :controller
  alias Butike.Backup
  alias Butike.Repo

  @doc """
  Returns the list of orders collection
  
  """
  def orders(conn, _params) do
    orders = Backup.list_orders()

    render(conn, "index.json", orders: orders)
  end

  def real_time(conn, attributes) do
    # 1. Insert into the database
    Backup.record(attributes)

    # 2. Construct the response
    response = %{
      "code" => 201,
      "status" => "success",
      "message" => "Real time backup taken"
    }

    json(conn, response)
  end

  def list_orders_by_shop(conn, %{"phone_number" => phone_number}) do
    json(conn, Backup.list_orders_by_phone(phone_number))
  end
end
