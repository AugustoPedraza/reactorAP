defmodule ReactorAp.HelpFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReactorAp.Help` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question",
        up_votes: 42
      })
      |> ReactorAp.Help.create_faq()

    faq
  end
end
