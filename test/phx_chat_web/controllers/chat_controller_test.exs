defmodule PhxChatWeb.ChatControllerTest do
  use PhxChatWeb.ConnCase

  describe "index" do
    test "renders the chat prompt", %{conn: conn} do
      conn = get(conn, Routes.chat_path(conn, :index))
      assert html_response(conn, 200) =~ "choose a username"
    end
  end
end
