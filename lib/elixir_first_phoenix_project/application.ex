defmodule ElixirFirstPhoenixProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirFirstPhoenixProject.Repo,
      # Start the Telemetry supervisor
      ElixirFirstPhoenixProjectWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirFirstPhoenixProject.PubSub},
      # Start the Endpoint (http/https)
      ElixirFirstPhoenixProjectWeb.Endpoint
      # Start a worker by calling: ElixirFirstPhoenixProject.Worker.start_link(arg)
      # {ElixirFirstPhoenixProject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirFirstPhoenixProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirFirstPhoenixProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
