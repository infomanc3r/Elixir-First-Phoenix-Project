defmodule ElixirFirstPhoenixProject.LikesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirFirstPhoenixProject.Likes` context.
  """

  @doc """
  Generate a like.
  """
  def like_fixture(attrs \\ %{}) do
    {:ok, like} =
      attrs
      |> Enum.into(%{

      })
      |> ElixirFirstPhoenixProject.Likes.create_like()

    like
  end
end
