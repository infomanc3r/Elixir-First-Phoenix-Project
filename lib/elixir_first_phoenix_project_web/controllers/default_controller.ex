defmodule ElixirFirstPhoenixProjectWeb.DefaultController do
  use ElixirFirstPhoenixProjectWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{message: "Welcome to ElixirFirstPhoenixProject"}))
  end

end
