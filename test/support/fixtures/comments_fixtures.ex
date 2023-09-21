defmodule ElixirFirstPhoenixProject.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirFirstPhoenixProject.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        body: "some body"
      })
      |> ElixirFirstPhoenixProject.Comments.create_comment()

    comment
  end
end
