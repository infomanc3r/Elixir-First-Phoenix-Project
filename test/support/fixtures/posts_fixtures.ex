defmodule ElixirFirstPhoenixProject.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirFirstPhoenixProject.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        title: "some title",
        body: "some body"
      })
      |> ElixirFirstPhoenixProject.Posts.create_post()

    post
  end
end
