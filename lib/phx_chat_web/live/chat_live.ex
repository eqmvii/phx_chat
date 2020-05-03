defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias PhxChat.Chat

  @impl true
  def mount(_params, _session, socket) do
    IO.puts "\n===========MOUNTING==========="
    IO.inspect _session
    IO.puts "=============================\n"

    {:ok, assign(socket, message: "", message_list: Chat.recent_messages() |> Enum.reverse())}
  end

  @impl true
  def handle_event("send_chat", %{"message_input" => message} = wut, socket) do
    # TODO ERIC move to service / context?
    Chat.create_message(%{user: "current_user", message: message})

    {:noreply,
      socket
      |> put_flash(:info, "Message Sent: \"#{message}\"")
      |> assign(msg: "")
      |> assign(message_list: Chat.recent_messages() |> Enum.reverse())
    }
  end
end
