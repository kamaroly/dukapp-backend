defmodule ButikeWeb.Api.BackupController do
  use ButikeWeb, :controller
  alias Butike.Backup.Backup

  def real_time(conn, attributes) do
    # 1. Insert into the database
    Backup.record(attributes)

    # 2. Construct the response
    json(conn, %{
      "code" => 200,
      "status" => "success",
      "message" => "Real time backup taken"
    })
  end

  def restore(conn, %{"shop_phone" => shop_phone}) do
    restored_backup = Backup.get_backup_for_shop(shop_phone)

    json(conn, restored_backup)
  end
end
