defmodule PhxChatWeb.AuthController do
  use PhxChatWeb, :controller

  # TODO ERIC test

  alias PhxChatWeb.ChatLive
  alias PhxChatWeb.Presence

  def auth(conn, %{"username" => username}) do
    if Enum.member?(Presence.list(ChatLive.presence_topic()), username) do
      # TODO ERIC handle more good
      raise "NO SIR NO WAY"
    else
      conn
      |> put_session(:username, username)
      |> redirect(to: Routes.chat_path(conn, :index))
    end
  end

  def login(conn, _params), do: render(conn)
end
