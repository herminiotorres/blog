defmodule HerminioTorres.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HerminioTorresWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HerminioTorres.PubSub},
      # Start the Endpoint (http/https)
      HerminioTorresWeb.Presence,
      HerminioTorresWeb.Endpoint
      # Start a worker by calling: HerminioTorres.Worker.start_link(arg)
      # {HerminioTorres.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HerminioTorres.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HerminioTorresWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
