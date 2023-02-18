defmodule Butike.BackupControllerTest do
  alias Butike.UserService
  alias Butike.Order.Order
  alias Butike.Order.OrderItem
  alias Butike.Item.Item
  alias Butike.Item.Inventory
  alias Butike.Customer.Customer
  alias Butike.Supplier.Supplier
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
        "code" => 200,
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

    test "Mobile phone can backup order items", %{conn: conn} do
      request_payload = %{
        query_string:
          "INSERT INTO order_items (shop_msisdn,name,item_id,order_id,description,variation_id,quantity,unit_cost_price,unit_sales_price,total,taxes,note,meta_data) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        query_parameters:
          "250781854852,Sale Item,123,1,Order description,0,10.0,7,8,70.0,0,Test note,[]"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      assert json_response(conn, 200) == %{
               "code" => 200,
               "status" => "success",
               "message" => "Real time backup taken"
             }

      order_items = Repo.all(OrderItem)
      assert Enum.count(order_items) == 1
    end

    test "Mobile phone can backup items", %{conn: conn} do
      request_payload = %{
        query_string:
          "INSERT INTO items (shop_msisdn,shop_item_id,name,description,category,reorder_level,quantity,cost_price,sale_price,is_service,note,meta_data) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
        query_parameters:
          "250781854852,2,Item Name,Item Description,1,49,90,43,23,97,well written note,another test"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      assert json_response(conn, 200) == %{
               "code" => 200,
               "status" => "success",
               "message" => "Real time backup taken"
             }

      items = Repo.all(Item)
      assert Enum.count(items) == 1
    end

    test "Mobile phone can backup item inventory", %{conn: conn} do
      request_payload = %{
        query_string:
          "INSERT INTO item_inventories (shop_msisdn,item_id,comment,quantity,amount) VALUES (?,?,?,?,?)",
        query_parameters: "250781854852,1,New stock,32,300"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      assert json_response(conn, 200) == %{
               "code" => 200,
               "status" => "success",
               "message" => "Real time backup taken"
             }

      item_inventories = Repo.all(Inventory)
      assert Enum.count(item_inventories) == 1
    end

    test "Mobile phone can backup customers", %{conn: conn} do
      request_payload = %{
        query_string:
          "INSERT INTO customers (address,email,meta_data,names,note,phone,shop_customer_id,shop_msisdn) VALUES (?,?,?,?,?,?,?,?)",
        query_parameters:
          "Gikondo Kicukiro,customer@remote.com,[],John Remote,Customer Well Note,250781854852,1,250781854852"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      assert json_response(conn, 200) == %{
               "code" => 200,
               "status" => "success",
               "message" => "Real time backup taken"
             }

      customers = Repo.all(Customer)
      assert Enum.count(customers) == 1
    end

    test "Mobile phone can backup suppliers", %{conn: conn} do
      request_payload = %{
        query_string:
          "INSERT INTO suppliers (address,company_name,email,meta_data,note,phone,shop_msisdn,shop_supplier_id,tin) VALUES (?,?,?,?,?,?,?,?,?)",
        query_parameters:
          "Nyenyeri Gikondo Kicukiro Kigali,DukApp Industry,suppliers@remote.com,[],Supplier Note,254757161010,250781854852,1,100594839"
      }

      conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, request_payload))

      assert json_response(conn, 200) == %{
               "code" => 200,
               "status" => "success",
               "message" => "Real time backup taken"
             }

      suppliers = Repo.all(Supplier)
      assert Enum.count(suppliers) == 1
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

      # Ensure the orders are created in the database
      assert Enum.count(response) > 1
    end
  end
end
