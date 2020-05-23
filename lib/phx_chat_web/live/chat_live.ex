defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias Phoenix.PubSub
  alias PhxChat.Chat
  alias PhxChatWeb.Presence
  alias PhxChatWeb.PresenceService

  @chat_messages_topic "chat_messages_topic"

  # A render callback could be used here. Since that callback isn't implemented,
  # the matching template phx_chat_web\live\chat_live.html.leex is automatically rendered

  @doc """
  Mount is typically called twice:
    * First statically when the Live View is first rendered.
    * Again once the client connects (use connected?() to do state-based work at that point)

  Setting page_title is a special case in Live View that allows the `<title>` tag to be dynamically controlled.
  """
  @impl true
  def mount(_params, %{"username" => username} = _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(PhxChat.PubSub, @chat_messages_topic)
      PubSub.subscribe(PhxChat.PubSub, PresenceService.presence_topic())

      Presence.track(self(), PresenceService.presence_topic(), username, %{
        online_at: inspect(System.system_time(:second))
      })

      {:ok,
       socket
       |> assign(page_title: "#{username} - Phx Chat")
       |> assign(message: "")
       |> assign(username: username)
       |> assign(online_users: PresenceService.online_users())
       |> assign(message_list: Chat.recent_messages()), temporary_assigns: [message_list: []]}
    else
      {:ok,
       assign(socket,
         online_users: [],
         page_title: nil,
         message: "",
         message_list: []
       )}
    end
  end

  @impl true
  def handle_event(
        "send_chat",
        %{"message_input" => message},
        %{assigns: %{username: username}} = socket
      ) do
    {:ok, new_message} = Chat.create_message(%{user: username, message: message})

    PubSub.broadcast_from(PhxChat.PubSub, self(), @chat_messages_topic, %{
      new_message: new_message
    })

    {:noreply,
     socket
     |> assign(message: "")
     |> assign(message_list: [new_message])}
  end

  ###############################
  # PubSub Subscribtion Handler #
  ###############################

  @impl true
  def handle_info(%{new_message: new_message}, socket) do
    IO.puts("\n[][][][] New Message Received by #{inspect(self())}[][][][]")
    {:noreply, assign(socket, message_list: [new_message])}
  end

  ############################
  # Phoenix Presence Handler #
  ############################

  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    {:noreply, assign(socket, online_users: PresenceService.online_users())}
  end
end
