defmodule ButikeWeb.PageController do
  use ButikeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
