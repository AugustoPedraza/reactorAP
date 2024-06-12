defmodule ReactorApWeb.RatingLive.Form do
  use ReactorApWeb, :live_component

  alias ReactorAp.Survey
  alias ReactorAp.Survey.Rating

  def update(%{current_user: user, product: product} = assigns, socket) do
    changeset =
      %Rating{user_id: user.id, product_id: product.id}
      |> Survey.change_rating()

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def handle_event("save", %{"rating" => rating_params}, socket) do
    {:noreply, save_rating(socket, rating_params)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp save_rating(%{assigns: %{product_index: product_index, product: product}} = socket, params) do
    case Survey.create_rating(params) do
      {:ok, rating} ->
        updated_product = %{product | ratings: [rating]}
        notify_parent({:created_rating, updated_product, product_index})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
