defmodule MnemosyneWeb.SourceController do
  use MnemosyneWeb, :controller

  alias Mnemosyne.Records
  alias Mnemosyne.Records.Source

  def index(conn, _params) do
    sources = Records.list_sources()
    IO.inspect(sources)
    render(conn, "index.html", sources: sources)
  end

  def new(conn, _params) do
    changeset = Records.change_source(%Source{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"source" => source_params}) do
    case Records.create_source(source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source created successfully.")
        |> redirect(to: Routes.source_path(conn, :show, source))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    source = Records.get_source!(id)
    render(conn, "show.html", source: source)
  end

  def snapshots(conn, %{"id" => id}) do
    source = Records.get_source!(id)
    render(conn, "snapshots_for_source.html", source: source)
  end


  def run(conn, %{"id" => id}) do
    source = Records.get_source!(id)
    ScrapeFromSource.run_source(source)
    conn
    |> put_flash(:info, "Creating snapshot.")
    |> redirect(to: Routes.source_path(conn, :show, source))
  end


  def edit(conn, %{"id" => id}) do
    source = Records.get_source!(id)
    changeset = Records.change_source(source)
    render(conn, "edit.html", source: source, changeset: changeset)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Records.get_source!(id)

    case Records.update_source(source, source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source updated successfully.")
        |> redirect(to: Routes.source_path(conn, :show, source))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", source: source, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Records.get_source!(id)
    {:ok, _source} = Records.delete_source(source)

    conn
    |> put_flash(:info, "Source deleted successfully.")
    |> redirect(to: Routes.source_path(conn, :index))
  end
end
