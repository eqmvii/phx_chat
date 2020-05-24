defmodule OnlineUserComponent do
  use Phoenix.LiveComponent

  # TODO ERIC: make stateful, make listen for changes in online users
  def render(assigns) do
    ~L"""
    <li class="user-list__username"><%= @content %></li>
    """
  end
end
