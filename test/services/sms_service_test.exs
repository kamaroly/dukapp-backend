defmodule Services.SmsServiceTest do
  use ButikeWeb.ConnCase
  alias Butike.SmsService

  test "User can send SMS using this application" do
    phone = "250791903386"

    message =
      "Your DUKAPP One Time Password(OTP) is \n\n 89342  \n\nValid for 2 minutes. Sent with Love."

    response = SmsService.send(phone, message)
    assert response.status_code == 200

    # Code 1701 means that the sms was sent successfully
    assert response.body =~ "1701|" <> phone
  end
end
