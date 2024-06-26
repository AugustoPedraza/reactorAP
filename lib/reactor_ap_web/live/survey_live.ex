defmodule ReactorApWeb.SurveyLive do
  use ReactorApWeb, :live_view

  alias __MODULE__.Component
  alias ReactorAp.{Catalog, Survey}
  alias ReactorApWeb.{Endpoint, DemographicLive, RatingLive}

  @survey_results_topic "survey_results"

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic()
     |> assign_products()}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end

  defp assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :products,
      Catalog.list_products_with_user_ratings(current_user)
    )
  end

  def handle_info(
        {ReactorApWeb.DemographicLive.Form, {:created_demographic, demographic}},
        socket
      ) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_info(
        {ReactorApWeb.RatingLive.Form, {:created_rating, updated_product, product_index}},
        socket
      ) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end

  defp handle_rating_created(
         %{assigns: %{products: products}} = socket,
         updated_product,
         product_index
       ) do
    Endpoint.broadcast(@survey_results_topic, "rating_created", %{})

    socket
    |> assign(:products, List.replace_at(products, product_index, updated_product))
  end
end
