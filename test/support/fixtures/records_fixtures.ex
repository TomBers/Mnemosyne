defmodule Mnemosyne.RecordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mnemosyne.Records` context.
  """

  @doc """
  Generate a snapshot.
  """
  def snapshot_fixture(attrs \\ %{}) do
    {:ok, snapshot} =
      attrs
      |> Enum.into(%{
        response: %{},
        type: "some type",
        url: "some url"
      })
      |> Mnemosyne.Records.create_snapshot()

    snapshot
  end

  @doc """
  Generate a source.
  """
  def source_fixture(attrs \\ %{}) do
    {:ok, source} =
      attrs
      |> Enum.into(%{
        active: true,
        page_elements: [],
        type: "some type",
        url: "some url"
      })
      |> Mnemosyne.Records.create_source()

    source
  end
end
