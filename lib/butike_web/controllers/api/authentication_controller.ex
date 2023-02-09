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

  def verify_otp(conn, %{"shop_phone" => shop_phone, "otp_code" => otp_code}) do
    # Prepare response
    response = %{
      code: 400,
      status: "error",
      message: "Could not verify OTP" <> otp_code <> " for phone " <> shop_phone
    }

    # case UserService.verify_otp(shop_phone, otp_code) do
    #   {:ok, _} ->
    #     response = %{
    #       code: 200,
    #       status: "success",
    #       message: "OTP Verified successfully for phone " <> shop_phone
    #     }
    # end

    # json(conn, response)
  end
end
