defmodule ElixirFirstPhoenixProjectWeb.Auth.Guardian do
  use Guardian, otp_app: :elixir_first_phoenix_project
  alias ElixirFirstPhoenixProject.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _claims) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => sub}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims{_claims} do
    {:error, :no_id_provided}
  end

end
