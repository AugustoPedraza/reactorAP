defmodule ReactorApWeb.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  alias ReactorAp.Survey.Demographic
  alias ReactorApWeb.CoreComponents

  attr :demographic, Demographic, required: true

  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">Demographics <%= raw("&#x2713;") %></h2>
      <CoreComponents.table rows={[@demographic]}>
        <:col :let={demographic} label="Gender">
          <%= demographic.gender %>
        </:col>
        <:col :let={demographic} label="Year of Birth">
          <%= demographic.year_of_birth %>
        </:col>
      </CoreComponents.table>
      <ul>
        <li>Gender: <%= @demographic.gender %></li>
        <li>Year of birth: <%= @demographic.year_of_birth %></li>
      </ul>
    </div>
    """
  end
end
