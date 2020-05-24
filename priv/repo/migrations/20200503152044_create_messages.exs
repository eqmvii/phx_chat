defmodule PhxChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      # TODO ERIC: Ecto defaults this to varchar 255 -- handle long and empty messages
      add :user, :string
      add :message, :string

      timestamps()
    end

  end
end
