defmodule ElixirFirstPhoenixProject.Schema.AccountTest do
  use ExUnit.Case
  alias ElixirFirstPhoenixProject.Accounts.Account
  alias Ecto.Changeset

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
      valid_params = %{
        "id" => Ecto.UUID.generate(),
        "email" => "account_test@testemail.com",
        "hash_password" => "testing_password",
        "inserted_at" => NaiveDateTime.local_now(),
        "updated_at" => NaiveDateTime.local_now()
      }

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
  end

end
