defmodule ReactorApWeb.WrongLive do
  use ReactorApWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        winner_number: _get_new_winner_number(),
        score: 0,
        msg: "Make a guess:"
      )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @msg %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    <h2>
      <%= live_patch("Reset my game", to: "#") %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    guess_number = String.to_integer(guess)
    winner_number = socket.assigns.winner_number

    {msg, score, new_winner_number} =
      if winner_number == guess_number do
        msg = "Lucky you! 👏. Keep going!"
        score = socket.assigns.score + 1
        new_winner_number = _get_new_winner_number(winner_number)

        {msg, score, new_winner_number}
      else
        msg = "Your guess: #{guess}. Wrong. Guess again."
        score = socket.assigns.score - 1

        {msg, score, winner_number}
      end

    {
      :noreply,
      assign(socket, msg: msg, score: score, winner_number: new_winner_number)
    }
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, assign(socket, score: 0, msg: "Make a guess:")}
  end

  defp _get_new_winner_number(previous_number \\ -1) do
    new_number = Enum.random(1..10)

    if new_number == previous_number do
      _get_new_winner_number(previous_number)
    else
      new_number
    end
  end
end
