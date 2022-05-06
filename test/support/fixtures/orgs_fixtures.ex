defmodule Mnemosyne.OrgsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mnemosyne.Orgs` context.
  """

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Mnemosyne.Orgs.create_company()

    company
  end
end
