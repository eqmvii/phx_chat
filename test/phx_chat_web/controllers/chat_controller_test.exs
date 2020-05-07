defmodule PhxChatWeb.ChatControllerTest do
  use PhxChatWeb.ConnCase

  describe "index" do
    test "redirects if the user is not logged in ", %{conn: conn} do
      conn = get(conn, Routes.chat_path(conn, :index))
      assert html_response(conn, 302) =~ "redirected"
    end
  end
end
