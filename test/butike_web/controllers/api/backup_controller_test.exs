defmodule Butike.BackupControllerTest do
	use ButikeWeb.ConnCase
	alias Butike.Backup

	describe "Real time backukp" do

		test "App can create real time backup", %{conn: conn} do
			# Prepare
			request_payload = %{
			    query_string: "INSERT INTO orders (shop_msisdn,order_type,quantity, item_id, item_name, item_description, customer_or_supplier_id, payment_mode) VALUES (? ,? ,?, ?, ?, ?, ?, ?)",
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
	end
end
