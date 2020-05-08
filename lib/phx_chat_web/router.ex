defmodule PhxChatWeb.Router do
  use PhxChatWeb, :router

  alias PhxChatWeb.PageViewsPlug
  alias PhxChatWeb.SessionPlug

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PhxChatWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug PageViewsPlug
    plug SessionPlug
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PhxChatWeb do
    pipe_through(:browser)

    post("/auth", AuthController, :auth)

    get("/login", AuthController, :login)
    post("/logout", AuthController, :logout)

    get("/chat", ChatController, :index)
    # TODO ERIC: Probably better to use the below syntax instead of doing a rende from within a traditional controller / component
    live("/", PageLive, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxChatWeb do
  #   pipe_through :api
  # end

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
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: PhxChatWeb.Telemetry)
    end
  end
end
