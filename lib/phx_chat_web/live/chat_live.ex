defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, msg: "", results: %{})}
  end

  @impl true
  def handle_event("send_chat", %{"msg_input" => msg_input}, socket) do
    IO.inspect msg_input

    {:noreply,
      socket
      |> put_flash(:info, "Message Sent: \"#{msg_input}\"")
      |> assign(msg: "")
    }
  end
end
