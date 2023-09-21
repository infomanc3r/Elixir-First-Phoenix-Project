defmodule ElixirFirstPhoenixProject.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields [:id, :inserted_at, :updated_at, :like]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :body, :string
    belongs_to :user, ElixirFirstPhoenixProject.Users.User
    belongs_to :post, ElixirFirstPhoenixProject.Posts.Post
    has_many :like, ElixirFirstPhoenixProject.Likes.Like

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, all_fields())
    |> validate_required(all_fields() -- @optional_fields)
    |> validate_length(:body, max: 10000)
  end

end
