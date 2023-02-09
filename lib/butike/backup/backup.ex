defmodule Butike.Backup.Backup do
  @moduledoc """
  The Backup Context
  """
  # Imports only from/2 of Ecto.Query
  alias Butike.Repo
  alias Ecto.Adapters.SQL
  alias Butike.Users.User
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

  @doc """
  Retrieves backup for a specific phone

  ## Examples
    iex> Butike.Backup.Backup.get_backup_for_phone(phone_number)
    [%User{}, ...]
  """
  def get_backup_for_shop(shop_phone) do
    Repo.get(User, 1)
    |> Repo.preload([:orders, :order_items, :items, :item_inventories, :customers, :suppliers])
  end
end
