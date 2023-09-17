defmodule ElixirFirstPhoenixProject.Guardian.GuardianTest do
  use ElixirFirstPhoenixProject.Support.DataCase
  alias ElixirFirstPhoenixProject.{Accounts, Accounts.Account}

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(ElixirFirstPhoenixProject.Repo)
  end

  describe "authenticate/2" do
    test "success: returns a token when given valid credentials" do
      account_params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(account_params)

      assert {:ok, token, _claims} = ElixirFirstPhoenixProjectWeb.Auth.Guardian.authenticate(returned_account.email, account_params["hash_password"])
      assert token
    end

    test "error: returns an error tuple when given invalid credentials" do
      account_params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(account_params)

      assert {:error, :unauthorized} = ElixirFirstPhoenixProjectWeb.Auth.Guardian.authenticate(returned_account.email, "wrong_password")
    end
  end

  describe "authenticate/1" do
    test "success: returns a token when given a valid token" do
      account_params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(account_params)

      {:ok, account, token} = ElixirFirstPhoenixProjectWeb.Auth.Guardian.authenticate(returned_account.email, account_params["hash_password"])

      assert {:ok, account, new_token} = ElixirFirstPhoenixProjectWeb.Auth.Guardian.authenticate(token)
      assert account
      assert new_token
    end

    test "error: raises an error when given an invalid token" do
      assert_raise ElixirFirstPhoenixProjectWeb.Auth.ErrorResponse.NotFound, fn ->
        ElixirFirstPhoenixProjectWeb.Auth.Guardian.authenticate("invalid_token")
      end
    end
  end

end
