defmodule Butike.BackupControllerTest do
	use ButikeWeb.ConnCase
	@endpoint ButikeWeb.Endpoint
	

	describe "Real time backukp" do

		test "App can create real time backup", %{"conn": conn} do

			payload = %{
			    "shop_msidn": "254757161010",
			    "resource": "items",
			    "action": "INSERT",
			    "columns": "['id', 'shop_msisdn', 'quantity', 'cost_price', 'sale_price']",
			    "values": "[1, '254757161010', 43, 473, 750]"
			}

			post(conn, Routes.api_v1_backup_real_time_path(conn, :real_time, payload))

			assert json_response(conn, 200) == %{
				"code" => 201,
				"status" => "success",
				"message" => "Real time backup taken"
			}
			
		end
	end
end
