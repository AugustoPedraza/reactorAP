defmodule ReactorAp.Survey.Demographic.Query do
  import Ecto.Query

  alias ReactorAp.Survey.Demographic

  def base do
    Demographic
  end

  def for_user(query \\ base(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end
end
