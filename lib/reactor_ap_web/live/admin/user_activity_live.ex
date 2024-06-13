defmodule ReactorApWeb.Admin.UserActivityLive do
  use ReactorApWeb, :live_component

  alias ReactorApWeb.Presence

  def update(_assigns, socket) do
    {:ok, assign_user_activity(socket)}
  end

  defp assign_user_activity(socket) do
    assign(socket, :user_activity, Presence.list_products_and_users())
  end
end
