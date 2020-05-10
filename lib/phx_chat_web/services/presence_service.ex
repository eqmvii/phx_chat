defmodule PhxChatWeb.PresenceService do
  alias PhxChatWeb.Presence

  # TODO ERIC: Bot announce when somebody enters or leaves chat

  @presence_topic "presence_topic"
  def presence_topic(), do: @presence_topic

  def online_users() do
    @presence_topic
    |> Presence.list()
    |> Enum.map(fn {k, _v} -> k end)
    |> Enum.sort()
  end
end
