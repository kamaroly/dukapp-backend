defmodule Butike.Repo do
  use Ecto.Repo,
    otp_app: :butike,
    adapter: Ecto.Adapters.MyXQL
end
