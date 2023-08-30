defmodule ElixirFirstPhoenixProject.Schema.AccountTest do
  use ElixirFirstPhoenixProject.Support.SchemaCase
  alias ElixirFirstPhoenixProject.Accounts.Account

  @expected_fields_with_types [
    {:id, :binary_id},
    {:email, :string},
    {:hash_password, :string},
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime}
  ]

  @optional_fields [:id, :inserted_at, :updated_at]

  describe "fields and types" do
    test "has: the correct fields and types" do
      actual_fields_with_types =
        for field <- Account.__schema__(:fields) do
          type = Account.__schema__(:type, field)
          {field, type}
        end

      assert MapSet.new(actual_fields_with_types) == MapSet.new(@expected_fields_with_types)
    end
  end

  describe "changeset/2" do
    test "success: returns a valid changeset when given valid arguments" do
      valid_params = valid_params(@expected_fields_with_types)

      changeset = Account.changeset(%Account{}, valid_params)

      assert %Changeset{valid?: true, changes: changes} = changeset

      mutated = [:hash_password]

      for {field, _type} <- @expected_fields_with_types, field not in mutated do
        actual = Map.get(changes, field)
        expected = valid_params[Atom.to_string(field)]
        assert actual == expected, "Values for #{field} do not match. Expected: #{expected}, \ngot: #{actual}."
      end

      assert Bcrypt.verify_pass(valid_params["hash_password"], Map.get(changes, :hash_password)),
            "Password: #{valid_params["hash_password"]} does not match \n#{Map.get(changes, :hash_password)}."
    end

    test "error: returns an error changeset when given uncastable values" do
      invalid_params = %{
        "id" => NaiveDateTime.local_now(),
        "email" => NaiveDateTime.local_now(),
        "hash_password" => NaiveDateTime.local_now(),
        "inserted_at" => "not a datetime",
        "updated_at" => "not a datetime"
      }

      assert %Changeset{valid?: false, errors: errors} = Account.changeset(%Account{}, invalid_params)

      for{field, _type} <- @expected_fields_with_types do
        assert errors[field], "Expected an error for #{field}, but there was none."

        {_, meta} = errors[field]
        assert meta[:validation] == :cast, "Expected a cast error for #{field}, but got #{meta[:validation]}."
      end
    end

    test "error: returns an error changeset when required fields missing" do
      params = %{}

      assert %Changeset{valid?: false, errors: errors} = Account.changeset(%Account{}, params)

      for{field, _type} <- @expected_fields_with_types, field not in @optional_fields do
        assert errors[field], "Expected an error for #{field}, but there was none."

        {_, meta} = errors[field]
        assert meta[:validation] == :required, "Expected a 'required' error for #{field}, but got #{meta[:validation]}."
      end

      for field <- @optional_fields do
        refute errors[field], "Expected no error for optional field: #{field}, but there was one."
      end
    end

    test "error: returns error changeset when an email address is reused" do
      Ecto.Adapters.SQL.Sandbox.checkout(ElixirFirstPhoenixProject.Repo)

      {:ok, existing_account} =
        %Account{}
        |> Account.changeset(valid_params(@expected_fields_with_types))
        |> ElixirFirstPhoenixProject.Repo.insert()

      changeset_with_repeated_email =
        %Account{}
        |> Account.changeset(
          valid_params(@expected_fields_with_types)
          |> Map.put("email", existing_account.email)
          )

      assert {:error, %Changeset{valid?: false, errors: errors}} = ElixirFirstPhoenixProject.Repo.insert(changeset_with_repeated_email)

      assert errors[:email], "The field :email is missing from errors."

      {_, meta} = errors[:email]

      assert meta[:constraint] == :unique, "The validation type, #{meta[:validation]}, is incorrect."
    end
  end

end
