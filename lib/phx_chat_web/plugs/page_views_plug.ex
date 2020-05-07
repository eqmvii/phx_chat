defmodule PhxChatWeb.PageViewsPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case Redix.command(:redix, ["EXISTS", "pageviews"]) do
      {:ok, 0} -> Redix.command(:redix, ["SET", "pageviews", 1])
      {:ok, 1} -> Redix.command(:redix, ["INCR", "pageviews"])
    end

    {:ok, page_views} = Redix.command(:redix, ["GET", "pageviews"])

    assign(conn, :page_views, page_views)
  end
end
