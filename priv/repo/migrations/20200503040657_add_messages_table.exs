defmodule PhxChat.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  # Run with:
  # mix ecto.migrate

  def change do
    create table("messages") do
      add :user,       :string
      add :message,    :string

      timestamps()
    end
  end
end
