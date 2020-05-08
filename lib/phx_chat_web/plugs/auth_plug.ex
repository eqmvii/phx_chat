defmodule PhxChatWeb.LogInRequiredPlug do
  import Plug.Conn

  # TODO ERIC test

  def init(opts), do: opts

  def call(conn, _opts) do
    username =
      conn
      |> get_session()
      |> Map.get("username", nil)

    if is_nil(username) do
      conn
      |> Phoenix.Controller.redirect(to: "/login")
      |> halt()
    else
      conn
    end
  end
end
