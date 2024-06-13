defmodule ReactorApWeb.Presence do
  use Phoenix.Presence,
    otp_app: :reactor_ap,
    pubsub_server: ReactorAp.PubSub

  alias ReactorApWeb.Presence

  @user_activity_topic "user_activity"

  def track_user(pid, product, user_email) do
    Presence.track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user_email}]}
    )
  end

  def list_products_and_users do
    @user_activity_topic
    |> Presence.list()
    |> Enum.map(&extract_product_with_users/1)
  end

  defp extract_product_with_users({product_name, %{metas: metas}}) do
    {product_name, users_from_metas_list(metas)}
  end

  defp users_from_metas_list(metas_list) do
    metas_list
    |> Enum.map(&users_from_meta_map/1)
    |> List.flatten()
    |> Enum.uniq()
  end

  defp users_from_meta_map(meta_map) do
    get_in(meta_map, [:users])
  end
end
