defmodule Mnemosyne.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :url, :string
      add :type, :string
      add :page_elements, {:array, :map}
      add :active, :boolean, default: false, null: false
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:sources, [:company_id])
  end
end
