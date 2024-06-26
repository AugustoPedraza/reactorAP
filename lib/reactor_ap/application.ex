defmodule ReactorAp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ReactorApWeb.Telemetry,
      # Start the Ecto repository
      ReactorAp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ReactorAp.PubSub},
      # Start Finch
      {Finch, name: ReactorAp.Finch},
      # Start the Endpoint (http/https)
      ReactorApWeb.Presence,
      ReactorApWeb.Endpoint
      # Start a worker by calling: ReactorAp.Worker.start_link(arg)
      # {ReactorAp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReactorAp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReactorApWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
