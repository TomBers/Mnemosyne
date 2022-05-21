defmodule Mnemosyne.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias Mnemosyne.Repo

  alias Mnemosyne.Records.Source

  @doc """
  Returns the list of sources.

  ## Examples

      iex> list_sources()
      [%Source{}, ...]

  """
  def list_sources do
    Repo.all(Source) |> Repo.preload(:company) |> Repo.preload(:snapshots)
  end

  def all_sources do
    Repo.all(Source)
  end

  def all_scraper_sources do
    query = from s in Source, where: s.type == "WebScraper"
    Repo.all(query)
  end

  def all_api_sources do
    query = from s in Source, where: s.type == "API"
    Repo.all(query)
  end

  @doc """
  Gets a single source.

  Raises `Ecto.NoResultsError` if the Source does not exist.

  ## Examples

      iex> get_source!(123)
      %Source{}

      iex> get_source!(456)
      ** (Ecto.NoResultsError)

  """
#  def get_source!(id), do: Repo.get!(Source, id) |> Repo.preload(:company) |> Repo.preload(:snapshots)

  def get_source!(id) do
    query =
      from(
        s in Source,
        where: s.id == ^id,
        select: s,
        preload: [
          :company,
          snapshots:
            ^from(
              snap in Mnemosyne.Records.Snapshot,
              order_by: [asc: snap.inserted_at]
            )
        ]
      )

    Repo.one!(query)
  end

  def get_source_by_url!(url), do: Repo.get_by!(Source, url: url)

  @doc """
  Creates a source.

  ## Examples

      iex> create_source(%{field: value})
      {:ok, %Source{}}

      iex> create_source(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_source(attrs \\ %{}) do
    %Source{}
    |> Source.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a source.

  ## Examples

      iex> update_source(source, %{field: new_value})
      {:ok, %Source{}}

      iex> update_source(source, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_source(%Source{} = source, attrs) do
    source
    |> Source.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a source.

  ## Examples

      iex> delete_source(source)
      {:ok, %Source{}}

      iex> delete_source(source)
      {:error, %Ecto.Changeset{}}

  """
  def delete_source(%Source{} = source) do
    Repo.delete(source)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking source changes.

  ## Examples

      iex> change_source(source)
      %Ecto.Changeset{data: %Source{}}

  """
  def change_source(%Source{} = source, attrs \\ %{}) do
    Source.changeset(source, attrs)
  end

  alias Mnemosyne.Records.Snapshot

  @doc """
  Returns the list of snapshots.

  ## Examples

      iex> list_snapshots()
      [%Snapshot{}, ...]

  """
  def list_snapshots do
    Repo.all(Snapshot)
  end

  @doc """
  Gets a single snapshot.

  Raises `Ecto.NoResultsError` if the Snapshot does not exist.

  ## Examples

      iex> get_snapshot!(123)
      %Snapshot{}

      iex> get_snapshot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snapshot!(id), do: Repo.get!(Snapshot, id)

  @doc """
  Creates a snapshot.

  ## Examples

      iex> create_snapshot(%{field: value})
      {:ok, %Snapshot{}}

      iex> create_snapshot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snapshot(attrs \\ %{}) do
    %Snapshot{}
    |> Snapshot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snapshot.

  ## Examples

      iex> update_snapshot(snapshot, %{field: new_value})
      {:ok, %Snapshot{}}

      iex> update_snapshot(snapshot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snapshot(%Snapshot{} = snapshot, attrs) do
    snapshot
    |> Snapshot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snapshot.

  ## Examples

      iex> delete_snapshot(snapshot)
      {:ok, %Snapshot{}}

      iex> delete_snapshot(snapshot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snapshot(%Snapshot{} = snapshot) do
    Repo.delete(snapshot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snapshot changes.

  ## Examples

      iex> change_snapshot(snapshot)
      %Ecto.Changeset{data: %Snapshot{}}

  """
  def change_snapshot(%Snapshot{} = snapshot, attrs \\ %{}) do
    Snapshot.changeset(snapshot, attrs)
  end
end
