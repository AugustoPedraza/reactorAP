defmodule ReactorApWeb.Admin.SurveyResultsLive do
  use ReactorApWeb, :live_component

  alias ReactorAp.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()}
  end

  defp assign_products_with_average_ratings(socket) do
    socket
    |> assign(
      :products_with_average_rating,
      Catalog.products_with_average_rating()
    )
  end
end
