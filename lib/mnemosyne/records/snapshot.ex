defmodule Mnemosyne.Records.Snapshot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snapshots" do
    field :response, :map
    field :type, :string
    field :url, :string
    field :source_id, :id

    timestamps()
  end

  @doc false
  def changeset(snapshot, attrs) do
    snapshot
    |> cast(attrs, [:url, :type, :response])
    |> validate_required([:url, :type, :response])
  end
end
