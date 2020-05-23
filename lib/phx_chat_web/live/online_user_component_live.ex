defmodule OnlineUserComponent do
  use Phoenix.LiveComponent

  # TODO ERIC: make stateful, make listen for changes in online users
  def render(assigns) do
    ~L"""
    <span class="username"><%= @content %></span>
    """
  end
end
