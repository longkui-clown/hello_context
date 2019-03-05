defmodule HelloContext.Repo do
  use Ecto.Repo,
    otp_app: :hello_context,
    adapter: Ecto.Adapters.Postgres
end
