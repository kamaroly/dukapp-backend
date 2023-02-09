defmodule Butike.BackupControllerTest do
  alias Butike.UserService
  alias Butike.Order.Order
  use ButikeWeb.ConnCase
  alias Butike.Backup.Backup
  alias Butike.Repo

  describe "Real time backukp" do
    test "App can create real time backup", %{conn: conn} do
      # Prepare
      request_payload = %{
        query_string:
          "INSERT INTO orders (coupon_lines,created_via,customer_supplier_id,customer_supplier_note,discount_tax,discount_total,fee_lines,meta_data,note,order_key,order_type,payments,prices_include_tax,refunds,shop_msisdn,shop_order_id,status,tax_lines,total,total_tax,version) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        query_parameters:
          "[],mobile-app,123,Customer Notes,20.0,10.0,[],[],Customer notes,OrderKeys <> Integer.to_string(Enum.random(100_000..999_999)),SALE,[],0,[],254757161010,1,COMPLETED,[],435.0,4340.0,1"
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
      orders = Repo.all(Order)
      assert Enum.count(orders) == 1
    end

    test "User can restore the backup by shop phone number", %{conn: conn} do
      order = %Order{
        coupon_lines: "[]",
        created_via: "mobile-app",
        customer_supplier_id: 123,
        customer_supplier_note: "Customer Notes",
        discount_tax: 20.0,
        discount_total: 10.0,
        fee_lines: "[]",
        meta_data: "[]",
        note: "Customer notes",
        order_key: "OrderKeys" <> Integer.to_string(Enum.random(100_000..999_999)),
        order_type: "SALE",
        payments: "[]",
        prices_include_tax: 0,
        refunds: "[]",
        shop_msisdn: "254757161010",
        shop_order_id: 1,
        status: "COMPLETED",
        tax_lines: "[]",
        total: 435.0,
        total_tax: 4340.0,
        version: "1"
      }

      # Create order
      Backup.create_order(order)
      UserService.create_by_phone(order.shop_msisdn)

      conn =
        get(
          conn,
          Routes.api_v1_backup_restore_shop_path(
            conn,
            :restore,
            order.shop_msisdn
          )
        )

      response = json_response(conn, 200)

      IO.inspect(response)
      # Ensure the orders are created in the database
      assert Enum.count(response) > 1
    end
  end
end
