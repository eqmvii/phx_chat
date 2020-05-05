use Mix.Config

config :phx_chat, PhxChat.Repo,
  url: System.get_env("POSTGRES_TEST_DB_URL"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_chat, PhxChatWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
