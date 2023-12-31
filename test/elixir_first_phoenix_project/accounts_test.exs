defmodule ElixirFirstPhoenixProject.AccountsTest do
  use ElixirFirstPhoenixProject.Support.DataCase
  alias ElixirFirstPhoenixProject.{Accounts, Accounts.Account}

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(ElixirFirstPhoenixProject.Repo)
  end

  describe "create_account/1" do
    test "success: inserts an account into database and returns that account" do
      params = Factory.string_params_for(:account)

      assert {:ok, %Account{} = returned_account} = Accounts.create_account(params)

      account_from_db = Repo.get(Account, returned_account.id)

      assert returned_account == account_from_db

      mutated = ["hash_password"]

      for {param_field, expected} <- params, param_field not in mutated do
        schema_field = String.to_existing_atom(param_field)
        actual = Map.get(account_from_db, schema_field)

        assert actual == expected, "Values did not match for field: #{param_field}\nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
      end

      assert Bcrypt.verify_pass(params["hash_password"], returned_account.hash_password),
          "Password: #{inspect(params["hash_password"])} does not match \mhash: #{inspect(returned_account.hash_password)}"

      assert account_from_db.inserted_at == account_from_db.updated_at
    end

    test "error: returns an error tuple if account cannot be created" do
      missing_params = %{}

      assert {:error, %Changeset{valid?: false}} = Accounts.create_account(missing_params)
    end
  end

  describe "get_account!/1" do
    test "success: returns account when given a valid UUID" do
      existing_account = Factory.insert(:account)

      assert returned_account = Accounts.get_account!(existing_account.id)
      assert returned_account == existing_account
    end

    test "error: raises Ecto.NoResultsError when the read account doesn't exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_account!(Ecto.UUID.autogenerate())
      end
    end
  end

  describe "get_account_by_email/1" do
    test "success: returns account when given a valid email" do
      existing_account = Factory.insert(:account)

      assert returned_account = Accounts.get_account_by_email(existing_account.email)
      assert returned_account == existing_account
    end

    test "error: raises Ecto.NoResultsError when the read account doesn't exist" do
      assert Accounts.get_account_by_email(Faker.Internet.email()) == nil
    end
  end

  describe "get_full_account/1" do
    test "success: returns full account with preloaded user when given a valid account id" do
      existing_user = Factory.insert(:user)

      existing_account = existing_user.account
      |> Repo.preload(:user)

      assert returned_account = Accounts.get_full_account(existing_account.id)
      assert returned_account == existing_account
      assert returned_account.user == existing_account.user
    end

    test "error: returns nil when the read account doesn't exist" do
      refute Accounts.get_full_account(Ecto.UUID.autogenerate())
    end
  end

  describe "update_account/2" do
    test "success: updates database and returns account" do
      existing_account = Factory.insert(:account)

      params =
        Factory.string_params_for(:account)
        |> Map.take(["email"])

      assert {:ok, returned_account} = Accounts.update_account(existing_account, params)

      account_from_db = Repo.get(Account, returned_account.id)

      assert returned_account == account_from_db

      expected_account_data =
        existing_account
        |> Map.from_struct()
        |> Map.put(:email, params["email"])

      for {field, expected} <- expected_account_data do
        actual = Map.get(account_from_db, field)

        assert actual == expected, "Values did not match for field: #{field}\nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
      end
    end

    test "error: returns error tuple if account cannot be updated" do
      existing_account = Factory.insert(:account)

      bad_params = %{"email" => NaiveDateTime.utc_now()}

      assert {:error, %Changeset{}} = Accounts.update_account(existing_account, bad_params)

      assert existing_account == Repo.get(Account, existing_account.id)
    end
  end

  describe "delete_account/1" do
    test "success: deletes account properly" do
      existing_account = Factory.insert(:account)

      assert {:ok, _deleted_account} = Accounts.delete_account(existing_account)
      refute Repo.get(Account, existing_account.id)
    end

    test "error: raises StaleEntryError if account does not exist" do
      account_not_in_db = %Account{
        email: Faker.Internet.email(),
        hash_password: Faker.Internet.slug(),
        id: Ecto.UUID.autogenerate()
      }

      assert_raise Ecto.StaleEntryError, fn ->
        Accounts.delete_account(account_not_in_db)
      end
    end
  end

  describe "list_accounts/0" do
    test "success: returns a list of all Accounts in db" do
      all_accounts = Enum.map(1..3, fn _ -> Factory.insert(:account) end)

      assert returned_accounts = Accounts.list_accounts()

      assert returned_accounts == all_accounts
    end
  end

end
