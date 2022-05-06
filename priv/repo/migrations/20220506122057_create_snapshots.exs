defmodule Mnemosyne.Repo.Migrations.CreateSnapshots do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add :url, :string
      add :type, :string
      add :response, :map
      add :source_id, references(:sources, on_delete: :nothing)

      timestamps()
    end

    create index(:snapshots, [:source_id])
  end
end
