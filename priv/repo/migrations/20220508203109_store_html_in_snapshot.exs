defmodule Mnemosyne.Repo.Migrations.StoreHtmlInSnapshot do
  use Ecto.Migration

  def change do
    alter table(:snapshots) do
      add :html, :text
    end
  end
end
