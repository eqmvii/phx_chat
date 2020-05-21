defmodule OnlineUserComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <span class="username"><%= @content %></span>
    """
  end
end
