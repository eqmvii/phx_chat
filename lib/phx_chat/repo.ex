defmodule PhxChat.Repo do
  use Ecto.Repo,
    otp_app: :phx_chat,
    adapter: Ecto.Adapters.Postgres
end
