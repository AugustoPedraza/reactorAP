defmodule ReactorApWeb.PromoLive do
  use ReactorApWeb, :live_view

  alias ReactorAp.Promo
  alias ReactorAp.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Promo Code")
     |> assign_recipient()
     |> assign_form()}
  end

  def handle_event("validate", %{"recipient" => recipient_params}, socket) do
    changeset =
      socket.assigns.recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("send", %{"recipient" => recipient_params}, socket) do
    case Promo.send_promo(recipient_params) do
      {:ok, _recipient} ->
        flash_msg = "Promo sent successfully"

        {:noreply,
         socket
         # |> put_flash(:info, flash_msg) "Promo sent successfully") #this isn't been displayed on html view.
         |> push_navigate(
           to: ~p"/?flash=#{flash_msg}",
           replace: true
         )}

      # |> assign_recipient()
      # |> assign_form()}

      # |> push_navigate(to: "/", replace: true)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_recipient(socket) do
    assign(socket, :recipient, %Recipient{})
  end

  defp assign_form(%{assigns: %{recipient: recipient}} = socket) do
    form =
      recipient
      |> Promo.change_recipient()
      |> to_form()

    assign(socket, :form, form)
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
