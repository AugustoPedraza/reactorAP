defmodule ReactorAp.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReactorAp.Survey` context.
  """

  import ReactorAp.{AccountsFixtures, CatalogFixtures}

  @doc """
  Generate a demographic.
  """
  def demographic_fixture(attrs \\ %{}) do
    {:ok, demographic} =
      attrs
      |> Enum.into(%{
        gender: "female",
        year_of_birth: 2000,
        user_id: user_fixture().id
      })
      |> ReactorAp.Survey.create_demographic()

    demographic
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 4,
        user_id: user_fixture().id,
        product_id: product_fixture().id
      })
      |> ReactorAp.Survey.create_rating()

    rating
  end
end
