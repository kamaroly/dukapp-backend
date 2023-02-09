defmodule Users.Api.AuthenticationControllerTest do
  use ButikeWeb.ConnCase
  alias Butike.Users.User
  alias Butike.Repo

  test "User can be registered with valid unique phone number", %{conn: conn} do
    shop_msisdn = "250781854852"
    conn = get(conn, Routes.api_v1_authentication_send_otp_path(conn, :send_otp, shop_msisdn))
    response = json_response(conn, 200)

    assert response["code"] == 200
    assert response["status"] == "success"
    assert response["message"] == "OTP Sent to " <> shop_msisdn <> " successful"
  end

  test "New user is saved in the database when the authentication is sent", %{conn: conn} do
    shop_msisdn = "250781854852"
    conn = get(conn, Routes.api_v1_authentication_send_otp_path(conn, :send_otp, shop_msisdn))
    response = json_response(conn, 200)

    assert response["code"] == 200

    # Ensure that the phone has been saved in the database
    shop = Repo.get_by(User, shop_phone: shop_msisdn)

    assert shop.shop_phone == shop_msisdn
    assert shop.otp !== nil
    assert shop.otp_expires_at == nil
    assert shop.created_at !== nil
    assert shop.updated_at !== nil
  end
end
