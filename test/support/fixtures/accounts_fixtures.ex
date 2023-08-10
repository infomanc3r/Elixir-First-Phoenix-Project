defmodule ElixirFirstPhoenixProject.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirFirstPhoenixProject.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        hash_password: "some hash_password",
        email: "some email"
      })
      |> ElixirFirstPhoenixProject.Accounts.create_account()

    account
  end
end
