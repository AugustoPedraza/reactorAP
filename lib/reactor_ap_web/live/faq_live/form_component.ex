defmodule ReactorApWeb.FaqLive.FormComponent do
  use ReactorApWeb, :live_component

  alias ReactorAp.Help

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage faq records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="faq-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:question]} type="text" label="Question" />
        <.input field={@form[:answer]} type="text" label="Answer" />
        <.input field={@form[:up_votes]} type="number" label="Up votes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Faq</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{faq: faq} = assigns, socket) do
    changeset = Help.change_faq(faq)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"faq" => faq_params}, socket) do
    changeset =
      socket.assigns.faq
      |> Help.change_faq(faq_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"faq" => faq_params}, socket) do
    save_faq(socket, socket.assigns.action, faq_params)
  end

  defp save_faq(socket, :edit, faq_params) do
    case Help.update_faq(socket.assigns.faq, faq_params) do
      {:ok, faq} ->
        notify_parent({:saved, faq})

        {:noreply,
         socket
         |> put_flash(:info, "Faq updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_faq(socket, :new, faq_params) do
    case Help.create_faq(faq_params) do
      {:ok, faq} ->
        notify_parent({:saved, faq})

        {:noreply,
         socket
         |> put_flash(:info, "Faq created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
