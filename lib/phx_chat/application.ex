defmodule PhxChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    # Ideally, we can get a unique node name from our Kubernetes pod name.
    # Failing that, Ecto can give each instance a UUID.
    # The node_name needs to be different for each instance of this application for the Redis PubSub to work.
    node_name =
      if is_nil(System.get_env("KUBERNETES_POD_NAME")) do
        Ecto.UUID.generate()
      else
        System.get_env("KUBERNETES_POD_NAME")
      end

    Logger.info("\n=== Application Starting with Redis PubSub Node Name: ===\n#{inspect(node_name)}\n\n")

    children = [
      # Start the Ecto repository
      PhxChat.Repo,
      # Start the Telemetry supervisor
      PhxChatWeb.Telemetry,
      # Connect to Redis container / pod
      {Redix, {System.get_env("PHOENIX_REDIS_URI"), name: :redix}},
      # Start the PubSub system via PubSub Redis
      {Phoenix.PubSub,
       adapter: Phoenix.PubSub.Redis,
       url: System.get_env("PHOENIX_REDIS_URI"),
       # testing with a random number for now. TODO ERIC ABSOLUTELY NOT THIS.
       node_name: node_name,
       name: PhxChat.PubSub,
       # lowered redis_pool_size to handle concurrent pod testing
       redis_pool_size: 3},
      # Presence must come after PubSub and before endpoint
      PhxChatWeb.Presence,
      # Start the Endpoint (http/https)
      PhxChatWeb.Endpoint
      # Start a worker by calling: PhxChat.Worker.start_link(arg)
      # {PhxChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhxChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
