defmodule ReactorApWeb.DemographicLive.Form do
  use ReactorApWeb, :live_component

  alias ReactorAp.Survey
  alias ReactorAp.Survey.Demographic

  def update(%{current_user: current_user} = assigns, socket) do
    changeset =
      %Demographic{user_id: current_user.id}
      |> Survey.change_demographic()

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    {:noreply, save_demographic(socket, demographic_params)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp save_demographic(socket, params) do
    case Survey.create_demographic(params) do
      {:ok, demographic} ->
        notify_parent({:created_demographic, demographic})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
