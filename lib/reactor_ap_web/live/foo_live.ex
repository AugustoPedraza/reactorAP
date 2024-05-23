defmodule ReactorApWeb.FooLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1>Hello, <%= @name %>!</h1>
      <p>The current time at UTC is <%= @time %></p>

      <div phx-window-keydown="keydown"> </div>

      <h2>The typed key was: <%= @typed_key %></h2>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, name: "Visitor", typed_key: nil, time: DateTime.utc_now())}
  end

  def handle_event("keydown", %{"key" => key}, socket) do
    {:noreply, assign(socket, typed_key: key)}
  end
end
