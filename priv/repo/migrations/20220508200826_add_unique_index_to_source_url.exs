defmodule Mnemosyne.Repo.Migrations.AddUniqueIndexToSourceUrl do
  use Ecto.Migration

  def change do
    create unique_index(:sources, [:url])
  end
end
