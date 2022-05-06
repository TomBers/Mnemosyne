defmodule MnemosyneWeb.SnapshotController do
  use MnemosyneWeb, :controller

  alias Mnemosyne.Records
  alias Mnemosyne.Records.Snapshot

  def index(conn, _params) do
    snapshots = Records.list_snapshots()
    render(conn, "index.html", snapshots: snapshots)
  end

  def new(conn, _params) do
    changeset = Records.change_snapshot(%Snapshot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"snapshot" => snapshot_params}) do
    case Records.create_snapshot(snapshot_params) do
      {:ok, snapshot} ->
        conn
        |> put_flash(:info, "Snapshot created successfully.")
        |> redirect(to: Routes.snapshot_path(conn, :show, snapshot))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    snapshot = Records.get_snapshot!(id)
    render(conn, "show.html", snapshot: snapshot)
  end

  def edit(conn, %{"id" => id}) do
    snapshot = Records.get_snapshot!(id)
    changeset = Records.change_snapshot(snapshot)
    render(conn, "edit.html", snapshot: snapshot, changeset: changeset)
  end

  def update(conn, %{"id" => id, "snapshot" => snapshot_params}) do
    snapshot = Records.get_snapshot!(id)

    case Records.update_snapshot(snapshot, snapshot_params) do
      {:ok, snapshot} ->
        conn
        |> put_flash(:info, "Snapshot updated successfully.")
        |> redirect(to: Routes.snapshot_path(conn, :show, snapshot))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", snapshot: snapshot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    snapshot = Records.get_snapshot!(id)
    {:ok, _snapshot} = Records.delete_snapshot(snapshot)

    conn
    |> put_flash(:info, "Snapshot deleted successfully.")
    |> redirect(to: Routes.snapshot_path(conn, :index))
  end
end
