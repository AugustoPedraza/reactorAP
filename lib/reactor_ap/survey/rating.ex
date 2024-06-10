defmodule ReactorAp.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  alias ReactorAp.Accounts.User
  alias ReactorAp.Catalog.Product

  schema "ratings" do
    field :stars, :integer

    belongs_to :user, User
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:stars, :user_id, :product_id])
    |> validate_required([:stars, :user_id, :product_id])
    |> validate_inclusion(:stars, 1..5)
    |> unique_constraint(:product_id, name: :uniq_rating_on_user_product)
  end
end
