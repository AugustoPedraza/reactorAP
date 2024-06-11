defmodule ReactorAp.Survey.Rating.Query do
  import Ecto.Query

  alias ReactorAp.Survey.Rating

  def base do
    Rating
  end

  def preload_user(user) do
    for_user(base(), user)
  end

  def for_user(query, user) do
    query
    |> where([r], r.user_id == ^user.id)
  end
end
