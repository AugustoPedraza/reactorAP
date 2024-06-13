defmodule ReactorApWeb.Admin.SurveyResultsLive do
  use ReactorApWeb, :live_component

  alias ReactorAp.Catalog
  alias Contex.Plot

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_age_group_filter()
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def handle_event("age_group_filter", %{"age_group_filter" => age_group_filter}, socket) do
    {:noreply,
     socket
     |> assign_age_group_filter(age_group_filter)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  defp assign_age_group_filter(socket) do
    socket |> assign(:age_group_filter, "all")
  end

  defp assign_age_group_filter(socket, age_group_filter) do
    socket |> assign(:age_group_filter, age_group_filter)
  end

  defp assign_products_with_average_ratings(
         %{assigns: %{age_group_filter: age_group_filter}} = socket
       ) do
    socket
    |> assign(
      :products_with_average_rating,
      get_products_with_average_ratings(%{age_group_filter: age_group_filter})
    )
  end

  defp get_products_with_average_ratings(filter) do
    filter
    |> Catalog.products_with_average_rating()
    |> case do
      [] -> Catalog.products_with_zero_rating()
      products -> products
    end
  end

  defp assign_dataset(
         %{assigns: %{products_with_average_rating: products_with_average_rating}} = socket
       ) do
    socket
    |> assign(
      :dataset,
      make_bar_chart_dataset(products_with_average_rating)
    )
  end

  defp assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    socket
    |> assign(:chart_svg, render_bar_chart(chart))
  end

  defp make_bar_chart_dataset(data) do
    Contex.Dataset.new(data)
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket
    |> assign(
      :chart,
      make_bar_chart(dataset)
    )
  end

  defp make_bar_chart(dataset) do
    Contex.BarChart.new(dataset)
  end

  defp render_bar_chart(chart) do
    Plot.new(900, 700, chart)
    |> Plot.titles(title(), subtitle())
    |> Plot.axis_labels(x_axis(), y_axis())
    |> Plot.to_svg()
  end

  defp title, do: "Product Ratings"
  defp subtitle, do: "average star ratings per product"
  defp x_axis, do: "products"
  defp y_axis, do: "stars"
end
