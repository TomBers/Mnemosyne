defmodule Mnemosyne.Records.Source do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sources" do
    field :active, :boolean, default: false
    field :page_elements, {:array, :map}
    field :type, :string
    field :url, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:url, :type, :page_elements, :active])
    |> validate_required([:url, :type, :page_elements, :active])
  end
end
