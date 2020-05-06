defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias Phoenix.PubSub
  alias PhxChat.Chat

  # TODO ERIC: Any need for a def render method?
  # TODO ERIC: Use temporary assigns and scrolling instead of stopping at the last 10?

  @doc """
  Mount is called when the Live View is first rendered.

  Setting page_title is a special case in Live View that allows the `<title>` tag to be dynamically controlled.
  """
  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: nil, message: "", message_list: [], username: nil)}
  end

  @impl true
  def handle_event(
        "send_chat",
        %{"message_input" => message},
        %{assigns: %{username: username}} = socket
      ) do
    Chat.create_message(%{user: username, message: message})

    PubSub.broadcast_from(PhxChat.PubSub, self(), "chat_messages_topic", :new_message)

    {:noreply,
     socket
     |> assign(message: "")
     |> assign(message_list: recent_messages())}
  end

  @impl true
  def handle_event("login", %{"username_input" => username}, socket) do
    PubSub.subscribe(PhxChat.PubSub, "chat_messages_topic")

    {:noreply,
     socket
     |> put_flash(:info, "Welcome to the Chat, #{username}!")
     |> assign(page_title: "#{username} - Phx Chat")
     |> assign(username: username)
     |> assign(message_list: recent_messages())}
  end

  ###############################
  # PubSub Subscribtion Handler #
  ###############################

  @impl true
  def handle_info(:new_message, socket) do
    IO.puts("\n[][][][] New Message Received by #{inspect(self())}[][][][]")
    {:noreply, assign(socket, message_list: recent_messages())}
  end

  ###
  ### Private Methods
  ###

  defp recent_messages(), do: Chat.recent_messages() |> Enum.reverse()
end
