defmodule PhxChatWeb.ChatController do
  use PhxChatWeb, :controller

  alias PhxChat.Chat
  alias PhxChat.Chat.Message

  # TODO ERIC: Move page views into their own Live View component

  def index(conn, _params) do
    # Redis page view counter proof-of-concept
    case Redix.command(:redix, ["EXISTS", "pageviews"]) do
      {:ok, 0} -> Redix.command(:redix, ["SET", "pageviews", 1])
      {:ok, 1} -> Redix.command(:redix, ["INCR", "pageviews"])
    end

    {:ok, page_views} = Redix.command(:redix, ["GET", "pageviews"])

    messages = Chat.list_messages()
    render(conn, messages: messages, page_views: page_views)
  end
end
