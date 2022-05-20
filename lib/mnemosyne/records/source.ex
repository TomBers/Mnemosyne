defmodule Mnemosyne.Records.Source do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mnemosyne.Orgs.Company
  alias Mnemosyne.Records.Snapshot

  schema "sources" do
    field :active, :boolean, default: false
    field :page_elements, {:array, :map}
    field :type, :string
    field :url, :string
    belongs_to :company, Company

    has_many :snapshots, Snapshot


    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:url, :type, :page_elements, :active, :company_id])
    |> validate_required([:url, :type, :page_elements, :active, :company_id])
  end
end
