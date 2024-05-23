defmodule ReactorAp.Repo do
  use Ecto.Repo,
    otp_app: :reactor_ap,
    adapter: Ecto.Adapters.Postgres
end
