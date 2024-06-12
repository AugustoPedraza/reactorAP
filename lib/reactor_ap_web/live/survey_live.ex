defmodule ReactorApWeb.SurveyLive do
  use ReactorApWeb, :live_view

  alias __MODULE__.Component
  alias ReactorAp.Survey
  alias ReactorApWeb.DemographicLive

  def mount(_params, _session, socket) do
    {:ok, assign_demographic(socket)}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end

  def handle_info(
        {ReactorApWeb.DemographicLive.Form, {:created_demographic, demographic}},
        socket
      ) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end
end
