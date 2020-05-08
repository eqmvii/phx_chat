defmodule PhxChatWeb.LogInRequiredPlugTest do
  use PhxChatWeb.ConnCase

  alias PhxChatWeb.LogInRequiredPlug

  test "returns an unaltered conn for authed users", %{conn: conn} do
    authed_conn = init_test_session(conn, %{username: "Tester"})

    post_plug_conn = LogInRequiredPlug.call(authed_conn, %{})

    assert is_nil(post_plug_conn.status)

    assert_raise RuntimeError, fn ->
      redirected_to(post_plug_conn)
    end

    assert authed_conn == post_plug_conn
  end

  test "redirects if not logged in", %{conn: conn} do
    unauthed_conn =
      conn
      # init_test_session is Phoenix magic that fakes a session, which the auth plug requires
      |> init_test_session(%{})
      |> LogInRequiredPlug.call(%{})

    assert unauthed_conn.status == 302
    assert redirected_to(unauthed_conn) == "/login"
  end
end
