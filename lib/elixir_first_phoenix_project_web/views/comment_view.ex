defmodule ElixirFirstPhoenixProjectWeb.CommentView do
  use ElixirFirstPhoenixProjectWeb, :view
  alias ElixirFirstPhoenixProjectWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      body: comment.body
    }
  end
end
