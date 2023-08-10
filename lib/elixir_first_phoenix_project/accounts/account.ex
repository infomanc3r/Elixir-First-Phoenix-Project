defmodule ElixirFirstPhoenixProject.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :hash_password, :string
    field :email, :string
    has_one :user, ElixirFirstPhoenixProject.Users.User

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have @ symbol, cannot have spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
  end
end
