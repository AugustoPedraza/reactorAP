defmodule ReactorApWeb.SurveyLive do
  use ReactorApWeb, :live_view

  alias __MODULE__.Component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
