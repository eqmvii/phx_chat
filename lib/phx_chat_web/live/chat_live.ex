defmodule PhxChatWeb.ChatLive do
  use PhxChatWeb, :live_view

  alias Phoenix.PubSub
  alias PhxChat.Chat
  alias PhxChatWeb.Presence

  # TODO ERIC: Any need for a def render method?
  # TODO ERIC: Use temporary assigns and scrolling instead of stopping at the last 10?

  @presence_topic "presence_topic"
  @chat_messages_topic "chat_messages_topic"

  @doc """
  Mount is typically called twice:
    * First statically when the Live View is first rendered.
    * Again once the client connects (use connected?() to do state-based work at that point)

  Setting page_title is a special case in Live View that allows the `<title>` tag to be dynamically controlled.
  """
  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, online_at: nil, page_title: nil, message: "", message_list: [], username: nil)}
  end

  @impl true
  def handle_event(
        "send_chat",
        %{"message_input" => message},
        %{assigns: %{username: username}} = socket
      ) do
    Chat.create_message(%{user: username, message: message})

    PubSub.broadcast_from(PhxChat.PubSub, self(), @chat_messages_topic, :new_message)

    {:noreply,
     socket
     |> assign(message: "")
     |> assign(message_list: recent_messages())}
  end

  @impl true
  def handle_event("login", %{"username_input" => username}, socket) do
    # TODO ERIC: Reject duplicate usernames to prevent very odd presence behavior
    # TODO ERIC: If this is moved to mounted, only call when connected
    PubSub.subscribe(PhxChat.PubSub, @chat_messages_topic)
    PubSub.subscribe(PhxChat.PubSub, @presence_topic)

    Presence.track(self(), @presence_topic, username, %{
      online_at: inspect(System.system_time(:second))
    })

    {:noreply,
     socket
     |> put_flash(:info, "Welcome to the Chat, #{username}!")
     |> assign(page_title: "#{username} - Phx Chat")
     |> assign(username: username)
     |> assign(online_users: online_users())
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


  ############################
  # Phoenix Presence Handler #
  ############################

  # TODO ERIC: Consider using diffs vs. list here
  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    {:noreply, assign(socket, online_users: online_users())}
  end

  ###
  ### Private Methods
  ###

  defp recent_messages(), do: Chat.recent_messages() |> Enum.reverse()

  defp online_users() do
    @presence_topic
    |> Presence.list()
    |> Enum.map(fn { k, _v } -> k end)
    |> Enum.sort()
  end
end
