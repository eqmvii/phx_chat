defmodule PhxChatWeb.AuthController do
  use PhxChatWeb, :controller

  # TODO ERIC test

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
end
