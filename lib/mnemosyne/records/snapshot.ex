defmodule Mnemosyne.Records.Snapshot do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mnemosyne.Records.Source

  schema "snapshots" do
    field :response, :map
    field :type, :string
    field :url, :string
    belongs_to :source, Source

    timestamps()
  end

  @doc false
  def changeset(snapshot, attrs) do
    snapshot
    |> cast(attrs, [:url, :type, :response])
    |> validate_required([:url, :type, :response])
  end
end
