defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias Phoenix.PubSub
  alias PhxChat.Chat

  # TODO ERIC: Any need for a def render method?

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(PhxChat.PubSub, "chat_messages")

    {:ok, assign(socket, message: "", message_list: recent_messages())}
  end

  @impl true
  def handle_event("send_chat", %{"message_input" => message} = wut, socket) do
    Chat.create_message(%{user: "current_user", message: message})

    PubSub.broadcast_from(PhxChat.PubSub, self(), "chat_messages", "new_message")

    {:noreply,
      socket
      |> put_flash(:info, "Message Sent: \"#{message}\"")
      |> assign(message: "")
      |> assign(message_list: recent_messages())
    }
  end

  ###############################
  # PubSub Subscribtion Handler #
  ###############################

  def handle_info(message, socket) do
    IO.puts "\n[][][][] New Message Received by #{inspect(self())}[][][][]"
    {:noreply, assign(socket, message_list: recent_messages)}
  end

  ###
  ### Private Methods
  ###

  defp recent_messages(), do: Chat.recent_messages() |> Enum.reverse()

end
