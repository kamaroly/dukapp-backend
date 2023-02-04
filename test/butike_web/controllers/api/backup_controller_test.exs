defmodule Butike.BackupControllerTest do
	use ButikeWeb.ConnCase
	alias Butike.Backup

	describe "Real time backukp" do

		test "App can create real time backup", %{conn: conn} do

			payload = %{
			    query_string: "INSERT INTO orders (shop_msisdn,order_type,quantity) VALUES (? ,? ,?)",
			    query_parameters: "254757161010,sale,1.72"
			}

			conn = post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, payload))

			# Ensure the response is correct
			assert json_response(conn, 200) == %{
				"code" => 201,
				"status" => "success",
				"message" => "Real time backup taken"
			}
			
			# Ensure that the data base been persisted in the database
			orders = Backup.list_orders()

			IO.inspect(Enum.count(orders))
		end
	end
end
