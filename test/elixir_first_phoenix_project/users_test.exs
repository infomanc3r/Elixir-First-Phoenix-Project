defmodule ElixirFirstPhoenixProject.UsersTest do
  use ElixirFirstPhoenixProject.Support.DataCase
  alias ElixirFirstPhoenixProject.{Users, Users.User, Accounts, Accounts.Account}

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(ElixirFirstPhoenixProject.Repo)
  end

  describe "create_user/2" do
    test "success: inserts a user into database and returns that user" do
      params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(params)
      account_from_db = Repo.get(Account, returned_account.id)

      assert{:ok, %User{} = created_user} = Users.create_user(account_from_db,
        %{:full_name => "Test User"})

      user_from_db = Repo.get(User, created_user.id)

      assert created_user == user_from_db
      assert user_from_db.full_name == "Test User"
      assert user_from_db.inserted_at == user_from_db.updated_at
    end

    test "error: returns an error tuple if user cannot be created" do
      missing_params = %{}

      assert {:error, %Changeset{valid?: false}} = Users.create_user(%Account{}, missing_params)
    end
  end

end
