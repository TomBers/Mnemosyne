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
end
