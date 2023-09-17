defmodule ElixirFirstPhoenixProject.Support.Factory do
  use ExMachina.Ecto, repo: ElixirFirstPhoenixProject.Repo
  alias ElixirFirstPhoenixProject.Accounts.Account
  alias ElixirFirstPhoenixProject.Users.User

  def account_factory do
    %Account{
      email: Faker.Internet.email(),
      hash_password: Faker.Internet.slug()
    }
  end

  def user_factory do
    %User{
      full_name: Faker.Person.name(),
      account: build(:account)
    }
  end

end
