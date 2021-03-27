defmodule EventsSPA.Repo do
  use Ecto.Repo,
    otp_app: :eventsSPA,
    adapter: Ecto.Adapters.Postgres
end
