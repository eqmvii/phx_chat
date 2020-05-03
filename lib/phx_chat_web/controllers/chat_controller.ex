defmodule PhxChatWeb.ChatController do
  use PhxChatWeb, :controller

  alias PhxChat.Chat
  alias PhxChat.Chat.Message

  # TODO ERIC: Remove most boilerplate code below that come from the generator

  def index(conn, _params) do
    # Redis page view counter proof-of-concept
    case Redix.command(:redix, ["EXISTS", "pageviews"]) do
      {:ok, 0} -> Redix.command(:redix, ["SET", "pageviews", 1])
      {:ok, 1} -> Redix.command(:redix, ["INCR", "pageviews"])
    end

    {:ok, page_views} = Redix.command(:redix, ["GET", "pageviews"])

    messages = Chat.list_messages()
    render(conn, messages: messages, page_views: page_views)
  end

  # def new(conn, _params) do
  #   changeset = Chat.change_message(%Message{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"message" => message_params}) do
  #   case Chat.create_message(message_params) do
  #     {:ok, message} ->
  #       conn
  #       |> put_flash(:info, "Message created successfully.")
  #       |> redirect(to: Routes.message_path(conn, :show, message))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   message = Chat.get_message!(id)
  #   render(conn, "show.html", message: message)
  # end

  # def edit(conn, %{"id" => id}) do
  #   message = Chat.get_message!(id)
  #   changeset = Chat.change_message(message)
  #   render(conn, "edit.html", message: message, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "message" => message_params}) do
  #   message = Chat.get_message!(id)

  #   case Chat.update_message(message, message_params) do
  #     {:ok, message} ->
  #       conn
  #       |> put_flash(:info, "Message updated successfully.")
  #       |> redirect(to: Routes.message_path(conn, :show, message))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", message: message, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   message = Chat.get_message!(id)
  #   {:ok, _message} = Chat.delete_message(message)

  #   conn
  #   |> put_flash(:info, "Message deleted successfully.")
  #   |> redirect(to: Routes.message_path(conn, :index))
  # end
end
