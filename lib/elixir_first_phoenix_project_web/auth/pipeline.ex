defmodule ElixirFirstPhoenixProjectWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :elixir_first_phoenix_project,
  module: ElixirFirstPhoenixProjectWeb.Auth.Guardian,
  error_handler: ElixirFirstPhoenixProjectWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

end
