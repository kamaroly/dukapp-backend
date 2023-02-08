defmodule ButikeWeb.Router do
  use ButikeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ButikeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ButikeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ButikeWeb.Api, as: :api do
    pipe_through :api

    scope "/v1", as: :v1 do
      scope "/authentication", as: :authentication do
        get "/:shop_phone/send-otp", AuthenticationController, :send_otp, as: :send_otp
      end

      # Backup routes
      scope "/backup", as: :backup do
        get "/orders", BackupController, :orders, as: :list_orders
        post "/real-time", BackupController, :real_time, as: :real_time

        get "/:phone_number/orders", BackupController, :list_orders_by_shop,
          as: :list_orders_by_shop
      end
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ButikeWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
