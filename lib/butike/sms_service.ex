defmodule Butike.SmsService do
  def send(destination, message) do
    # SMS parameters
    parameters = %{
      username: "mtec-goldgate",
      password: "Admin@21",
      type: "0",
      dlr: "1",
      source: "DUKAPP",
      destination: destination,
      message: message
    }

    # SMS Gateway
    url = "http://rslr.connectbind.com:8080/bulksms/bulksms"

    HTTPoison.get!(url, [], params: parameters)
  end
end
