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

  describe "get_user!/1" do
    test "success: returns user when given a valid UUID" do
      params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(params)
      account_from_db = Repo.get(Account, returned_account.id)

      {:ok, %User{} = existing_user} = Users.create_user(account_from_db, %{:full_name => "Test User"})

      assert returned_user = Users.get_user!(existing_user.id)
      assert returned_user == existing_user
    end

    test "error: raises Ecto.NoResultsError when the read user doesn't exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Users.get_user!(Ecto.UUID.autogenerate())
      end
    end
  end

  describe "update_user/2" do
    test "success: updates database and returns user" do
      account_params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(account_params)
      account_from_db = Repo.get(Account, returned_account.id)

      {:ok, %User{} = existing_user} = Users.create_user(account_from_db, %{:full_name => "Test User"})

      assert {:ok, returned_user} = Users.update_user(existing_user, %{:full_name => "Test User Two"})

      user_from_db = Repo.get(User, returned_user.id)

      assert returned_user == user_from_db

      assert returned_user.full_name == user_from_db.full_name

      assert returned_user.full_name == "Test User Two"
      assert user_from_db.full_name == "Test User Two"
    end

    test "error: returns error tuple if user cannot be updated" do
      params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(params)
      account_from_db = Repo.get(Account, returned_account.id)

      {:ok, %User{} = existing_user} = Users.create_user(account_from_db, %{:full_name => "Test User"})

      bad_params = %{"full_name" => NaiveDateTime.utc_now()}

      assert {:error, %Changeset{}} = Users.update_user(existing_user, bad_params)

      assert existing_user == Repo.get(User, existing_user.id)
    end
  end

  describe "delete_user/1" do
    test "success: deletes user properly" do
      params = Factory.string_params_for(:account)
      {:ok, %Account{} = returned_account} = Accounts.create_account(params)
      account_from_db = Repo.get(Account, returned_account.id)

      {:ok, %User{} = existing_user} = Users.create_user(account_from_db, %{:full_name => "Test User"})

      assert {:ok, _deleted_user} = Users.delete_user(existing_user)
      refute Repo.get(User, existing_user.id)
    end
    
    test "error: raises StaleEntryError if user does not exist" do
      user_not_in_db = %User{
        id: Ecto.UUID.autogenerate()
      }

      assert_raise Ecto.StaleEntryError, fn ->
        Users.delete_user(user_not_in_db)
      end
    end
  end

end
