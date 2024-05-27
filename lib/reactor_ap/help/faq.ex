defmodule ReactorAp.Help.Faq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :up_votes, :integer

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :up_votes])
    |> validate_required([:question, :answer, :up_votes])
    |> validate_number(:up_votes, greater_than_or_equal_to: 0)
  end
end
