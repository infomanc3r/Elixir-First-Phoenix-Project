defmodule ElixirFirstPhoenixProjectWeb.Router do
  use ElixirFirstPhoenixProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirFirstPhoenixProjectWeb do
    pipe_through :api
  end
end
