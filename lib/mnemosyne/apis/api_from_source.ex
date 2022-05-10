defmodule ApiFromSource do

  alias Mnemosyne.Records

  def run_sources(sources) do
    sources
    |> Enum.map(fn source -> apply(String.to_atom("Elixir.#{source.url}"), :run, [source]) end)
    |> Enum.map(fn {response, source} -> Records.create_snapshot(%{url: source.url, type: "API", response: response, source_id: source.id, html: Jason.encode!(response)}) end)
  end
end