defmodule ElixirFirstPhoenixProject.Support.Factory do
  use ExMachina.Ecto, repo: ElixirFirstPhoenixProject.Repo
  alias ElixirFirstPhoenixProject.Accounts.Account

  def account_factory do
    %Account{
      email: Faker.Internet.email(),
      hash_password: Faker.Internet.slug()
    }
  end

end
