# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elixir_first_phoenix_project,
  ecto_repos: [ElixirFirstPhoenixProject.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :elixir_first_phoenix_project, ElixirFirstPhoenixProjectWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ElixirFirstPhoenixProjectWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ElixirFirstPhoenixProject.PubSub,
  live_view: [signing_salt: "x4fOk/MU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir_first_phoenix_project, ElixirFirstPhoenixProjectWeb.Auth.Guardian,
  issuer: "elixir_first_phoenix_project",
  secret_key: "e06xhTpHRnBLatoNM6EmaLqXewS7T9TmS+wpBiX5gMtMndsQ7OhgtvJF385IWrHr"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
