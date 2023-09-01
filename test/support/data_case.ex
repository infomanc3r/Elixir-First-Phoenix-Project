defmodule ElixirFirstPhoenixProject.Support.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ecto.Changeset
      import ElixirFirstPhoenixProject.Support.DataCase
      alias ElixirFirstPhoenixProject.{Support.Factory, Repo}
    end
  end

  setup _ do
    Ecto.Adapters.SQL.Sandbox.mode(ElixirFirstPhoenixProject.Repo, :manual)
  end

end
