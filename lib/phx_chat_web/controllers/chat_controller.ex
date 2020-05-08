defmodule PhxChatWeb.ChatController do
  use PhxChatWeb, :controller

  plug PhxChatWeb.LogInRequiredPlug when action in [:index]

  def index(conn, _params) do
    render(conn)
  end
end
