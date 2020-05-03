defmodule PhxChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhxChat.Repo,
      # Start the Telemetry supervisor
      PhxChatWeb.Telemetry,
      # Connect to Redis container / pod
      {Redix, host: "redis", port: 6379, name: :redix},
      # Start the PubSub system via PubSub Redis
      # TODO ERIC: Update node_name to something like # System.get_env("NODE)")
      {Phoenix.PubSub, adapter: Phoenix.PubSub.Redis, host: "redis", port: 6379, node_name: "onenodetorulethemall", name: PhxChat.PubSub},
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
