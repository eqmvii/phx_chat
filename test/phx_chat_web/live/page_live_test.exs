defmodule PhxChatWeb.PageLiveTest do
  use PhxChatWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Resources"
    assert render(page_live) =~ "Resources"
  end

  # TODO ERIC more tests; test with assert render_submit(view, :save, %{deg: 30}) =~ "The temperature is: 30℉"
end
