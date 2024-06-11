defmodule ReactorApWeb.SurveyLive do
  use ReactorApWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
