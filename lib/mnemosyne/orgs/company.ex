defmodule Mnemosyne.Orgs.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mnemosyne.Records.Source

  schema "companies" do
    field :name, :string

    has_many :sources, Source

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
