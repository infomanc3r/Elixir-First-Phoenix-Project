import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :elixir_first_phoenix_project, ElixirFirstPhoenixProject.Repo,
  username: "backend_stuff",
  password: "blork_backend",
  hostname: "localhost",
  database: "elixir_first_phoenix_project_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_first_phoenix_project, ElixirFirstPhoenixProjectWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "VO0sEDlKSOsNAPWYd5Dg9Gc5D9tvdZ7KtPTQ22feSRso8zTwf9ng3OWIW1gDm+Kb",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
