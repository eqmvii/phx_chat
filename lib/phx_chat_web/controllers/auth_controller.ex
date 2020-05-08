defmodule PhxChatWeb.AuthController do
  use PhxChatWeb, :controller

  # TODO ERIC test
  # TODO limit usernames to a sane number of characters

  alias PhxChatWeb.PresenceService

  def auth(conn, %{"username" => username}) do
    if Enum.member?(PresenceService.online_users(), username) do
      conn
      |> put_flash(:error, "Username already taken (#{username})")
      |> redirect(to: Routes.auth_path(conn, :login))
    else
      conn
      |> put_session(:username, username)
      |> redirect(to: Routes.chat_path(conn, :index))
    end
  end

  def login(conn, _params), do: render(conn)

  def logout(conn, _params) do
    conn
    |> clear_session
    |> redirect to: Routes.auth_path(conn, :login)
  end
end
