defmodule ButikeWeb.Api.BackupView do
	use ButikeWeb, :view 

  def render("index.json", %{orders: orders}) do
    orders
  end
end