defmodule ElixirFirstPhoenixProject.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes, primary_key: false) do
      add :id, :binary_id, primary_key: true

      timestamps()
    end
  end
end
