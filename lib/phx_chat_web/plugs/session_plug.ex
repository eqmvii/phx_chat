defmodule PhxChatWeb.SessionPlug do
  import Plug.Conn

  # TODO ERIC test

  def init(opts), do: opts

  @doc """
  Responsible for taking session info and putting it in conn.assigns for header template, etc.
  """
  def call(conn, _opts) do
    username =
      conn
      |> get_session()
      |> Map.get("username", nil)

      assign(conn, :username, username)
  end
end
