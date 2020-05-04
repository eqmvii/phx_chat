use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# TODO ERIC: Not this; this connects to the standard database for tests which is no bueno
config :phx_chat, PhxChat.Repo,
  username: "postgres",
  password: "verysecurepassword",
  database: "phx_chat_dev",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_chat, PhxChatWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
