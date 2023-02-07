defmodule Butike.BackupControllerTest do
  alias Butike.Backup.Order
  use ButikeWeb.ConnCase
  alias Butike.Backup
  alias Butike.Repo

  describe "Real time backukp" do
    test "App can create real time backup", %{conn: conn} do
      # Prepare
      request_payload = %{
        query_string:
          "INSERT INTO orders (shop_msisdn,order_type,quantity, item_id, item_name, item_description, customer_or_supplier_id, payment_mode) VALUES (? ,? ,?, ?, ?, ?, ?, ?)",
        query_parameters: "254757161010,sale,1.72,37,testing_item_name,item description,3,m-pesa"
      }

      response_payload = %{
        "code" => 201,
        "status" => "success",
        "message" => "Real time backup taken"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      # Ensure the response is correct
      assert json_response(conn, 200) == response_payload

      # Ensure that the data base been persisted in the database
      orders = Backup.list_orders()
      assert Enum.count(orders) == 1
    end

    test "User can retrieve orders by shop phone" do
      # 1. Create user in the database
      order = %Order{
        shop_msisdn: "250781854852",
        order_type: "purchase",
        item_id: 43,
        item_name: "Sale Item",
        item_description: "Why is this even a sale",
        customer_or_supplier_id: 1,
        quantity: 43,
        cost_price: 2,
        sale_price: 3,
        payment_mode: "m-pesa"
      }

      Backup.create_order(order)
      Backup.create_order(order)

      stored_orders = Backup.get_orders_by_phone(order.shop_msisdn)

      assert Enum.count(stored_orders) == 2
    end

    test "get_orders_by_phone returns 0 results when there is no matching phone" do
      order = %Order{
        shop_msisdn: "250781854852",
        order_type: "purchase",
        item_id: 43,
        item_name: "Sale Item",
        item_description: "Why is this even a sale",
        customer_or_supplier_id: 1,
        quantity: 43,
        cost_price: 2,
        sale_price: 3,
        payment_mode: "m-pesa"
      }

      Backup.create_order(order)

      empty_orders = Backup.get_orders_by_phone("2547575772")

      assert Enum.count(empty_orders) == 0
    end
  end
end
