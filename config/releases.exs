# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
#
# This is calculated at runtime, see here for more details
# https://hexdocs.pm/phoenix/releases.html#runtime-configuration
import Config

database_url = System.get_env("DATABASE_URL")

config :phx_chat, PhxChat.Repo,
  # removing the ssl requirement because of the GCP sidecar architecture: in production, this container shares a pod
  # with the could proxy container, which it connects to over localhost. The cloud proxy then encrupts and connects to
  # the GCP Cloud SQL database.
  # ssl: true,
  url: database_url,
  # Pool size configured low to account for Kubernetes testing and 20 connection limit on Heroku PG
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "4")

# Defaulting to an insecure string so we can compile a prod container, then run it with a differnt environment variable
secret_key_base = System.get_env("SECRET_KEY_BASE") || "definitelynotasecurestring"

config :phx_chat, PhxChatWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#

config :phx_chat, PhxChatWeb.Endpoint, server: true

#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
