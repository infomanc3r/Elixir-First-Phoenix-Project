defmodule ElixirFirstPhoenixProjectWeb.Auth.ErrorResponse.Unauthorized do
  defexception [message: "Unauthorized", plug_status: 401]
end

defmodule ElixirFirstPhoenixProjectWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "Forbidden", plug_status: 403]
end

defmodule ElixirFirstPhoenixProjectWeb.Auth.ErrorResponse.NotFound do
  defexception [message: "Not Found", plug_status: 404]
end
