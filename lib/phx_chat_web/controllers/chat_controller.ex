defmodule PhxChatWeb.ChatController do
  use PhxChatWeb, :controller

  plug PhxChatWeb.AuthPlug when action in [:index]

  # TODO ERIC Fix this: Very hacky way to jam a username form input into the session.
  # Do the auth flow better, like with a plug.
  # Ex.: raise inspect fetch_session(conn) |> get_session(:username)
  # TODO ERIC: Logout button and logged in messaging
  def index(conn, %{"username_input" => username}) do
    conn
    |> put_session(:logged_in, true)
    |> put_session(:username, username)
    |> render(logged_in: true, page_views: conn.assigns.page_views)
  end
  def index(conn, _params) do
    render(conn, logged_in: false, page_views: conn.assigns.page_views)
  end
end
