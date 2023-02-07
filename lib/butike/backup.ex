defmodule Butike.Backup do
  @moduledoc """
  The Backup Context
  """
  # Imports only from/2 of Ecto.Query
  import Ecto.Query
  alias Butike.Repo
  alias Ecto.Adapters.SQL
  alias Butike.Backup.Order
  alias Butike.Helpers.EnumHelper

  @doc """
  Backups an order
  """
  def record(attributes) do
    # query_values = attributes["query_parameters"]
    parameters =
      String.split(attributes["query_parameters"], ",")
      |> EnumHelper.sanatize()

    query = attributes["query_string"]

    SQL.query!(Repo, query, parameters)
  end

  def create_order(order) do
    Repo.insert!(order)
  end

  def list_orders_by_phone(phone_number) do
    # Send the query to the repository
    Repo.all(from(order in Butike.Backup.Order, where: order.shop_msisdn == ^phone_number))
  end

  @doc """
  Returns the list of orders
  
  ## Examples
  
  	iex> list_orders()
  	[%Order{}, ...]
  
  """
  def list_orders() do
    Repo.all(from(order in Butike.Backup.Order))
  end
end
