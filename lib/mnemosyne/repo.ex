defmodule Mnemosyne.Repo do
  use Ecto.Repo,
    otp_app: :mnemosyne,
    adapter: Ecto.Adapters.Postgres
end
