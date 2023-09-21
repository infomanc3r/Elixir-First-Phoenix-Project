defmodule ElixirFirstPhoenixProject.Likes.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields [:id, :inserted_at, :updated_at]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "likes" do
    belongs_to :user, ElixirFirstPhoenixProject.Users.User
    belongs_to :post, ElixirFirstPhoenixProject.Posts.Post
    belongs_to :comment, ElixirFirstPhoenixProject.Comments.Comment

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, all_fields())
    |> validate_required(all_fields() -- @optional_fields)
  end

end
