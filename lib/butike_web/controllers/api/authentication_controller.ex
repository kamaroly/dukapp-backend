defmodule ButikeWeb.Api.AuthenticationController do
  use ButikeWeb, :controller
  alias Butike.UserService

  def send_otp(conn, %{"shop_phone" => shop_phone}) do
    # Create user in the database
    UserService.create_by_phone(shop_phone)

    json(conn, %{
      code: 200,
      status: "success",
      message: "OTP Sent to " <> shop_phone <> " successful"
    })
  end
end
