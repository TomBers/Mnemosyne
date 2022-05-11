defmodule MnemosyneWeb.CompanyView do
  use MnemosyneWeb, :view


  def last_snapshot(snapshots) do
    get_date(List.last(snapshots))
  end

  defp get_date(nil) do
    "N/A"
  end

  defp get_date(snapshot) do
    Map.get(snapshot, :updated_at)
  end

  def get_page_elements(nil) do
    []
  end

  def get_page_elements(elements) do
    elements
  end

end
