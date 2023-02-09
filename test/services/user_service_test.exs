defmodule Services.UserServiceTest do
  use ButikeWeb.ConnCase
  alias Butike.UserService
  alias Butike.Helpers.StringHelper

  test "User can be registered using phone only" do
    phone = "254757161010"
    otp_code = "29832"
    {:ok, response} = UserService.register_user_by_phone(phone, otp_code)

    assert StringHelper.hash_md5(otp_code) == response.otp
  end

  test "User van be verified using phone and OTP" do
    phone = "254757161010"
    otp_code = "29923"

    UserService.register_user_by_phone(phone, otp_code)

    # Confirm that we can verify the otp code
    assert UserService.is_otp_valid(phone, otp_code) == true
  end
end
