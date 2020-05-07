defmodule PhxChatWeb.PageViewsPlugTest do
  use PhxChatWeb.ConnCase

  alias PhxChatWeb.PageViewsPlug

  # This test relies on a connection to the Redis store in the test environment
  test "renders the chat prompt", %{conn: conn} do
    %{assigns: assigns} = PageViewsPlug.call(conn, [])

    refute is_nil(assigns.page_views)
  end
end
