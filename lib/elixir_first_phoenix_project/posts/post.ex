defmodule ElixirFirstPhoenixProject.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields [:id, :inserted_at, :updated_at]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, ElixirFirstPhoenixProject.Users.User
    has_many :comment, ElixirFirstPhoenixProject.Comments.Comment
    has_many :like, ElixirFirstPhoenixProject.Likes.Like

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, all_fields())
    |> validate_required(all_fields() -- @optional_fields)
    |> validate_length(:title, max: 160)
    |> validate_length(:body, max: 10000)
  end

end
