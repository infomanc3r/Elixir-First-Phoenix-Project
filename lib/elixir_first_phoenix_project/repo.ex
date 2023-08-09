defmodule ElixirFirstPhoenixProject.Repo do
  use Ecto.Repo,
    otp_app: :elixir_first_phoenix_project,
    adapter: Ecto.Adapters.Postgres
end
