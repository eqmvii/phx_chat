defmodule PhxChatWeb.Presence do
  use Phoenix.Presence,
    otp_app: :phx_chat,
    pubsub_server: PhxChat.PubSub
end
