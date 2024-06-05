defmodule ReactorApWeb.PageController do
  use ReactorApWeb, :controller

  def home(conn, %{"flash" => flash_message}) do
    conn
    |> put_flash(:info, flash_message)
    |> render(:home)
  end

  def home(conn, _params) do
    render(conn, :home)
  end
end
