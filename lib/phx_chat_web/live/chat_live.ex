defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias PhxChat.Chat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "", message_list: Chat.list_messages())}
  end

  @impl true
  def handle_event("send_chat", %{"message_input" => message}, socket) do
    # TODO ERIC move to service / context?
    Chat.create_message(%{user: "current_user", message: message})

    {:noreply,
      socket
      |> put_flash(:info, "Message Sent: \"#{message}\"")
      |> assign(msg: "")
      |> assign(message_list: Chat.list_messages())
    }
  end
end
