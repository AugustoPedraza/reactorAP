defmodule ReactorAp.Promo do
  alias Ecto.Changeset
  alias ReactorAp.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(attrs) do
    # TODO: send the email
    # {:ok, _result} <- send_email_api_call(...)
    with changeset <- Recipient.changeset(%Recipient{}, attrs),
         {:ok, recipient} <- Changeset.apply_action(changeset, :update) do
      {:ok, recipient}
    end
  end
end
