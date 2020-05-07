defmodule PhxChatWeb.ChatController do
  use PhxChatWeb, :controller

  # TODO ERIC Fix this: Very hacky way to jam a username form input into the session.
  # Do the auth flow better, like with a plug.
  # Ex.: raise inspect fetch_session(conn) |> get_session(:username)
  # TODO ERIC: Logout button and logged in messaging
  def index(conn, %{"username_input" => username}) do
    conn
    |> put_session(:logged_in, true)
    |> put_session(:username, username)
    |> render(logged_in: true, page_views: page_views())
  end
  def index(conn, _params) do
    render(conn, logged_in: false, page_views: page_views())
  end

  ###
  ### Private Methods
  ###

  # TODO ERIC: Move to a plug and/or separate live view? Proof of concept for handling page views via redis
  defp page_views() do
    case Redix.command(:redix, ["EXISTS", "pageviews"]) do
      {:ok, 0} -> Redix.command(:redix, ["SET", "pageviews", 1])
      {:ok, 1} -> Redix.command(:redix, ["INCR", "pageviews"])
    end

    {:ok, page_views} = Redix.command(:redix, ["GET", "pageviews"])

    page_views
  end
end
