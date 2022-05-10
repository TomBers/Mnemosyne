defmodule ApiFromSource do

  alias Mnemosyne.Records

  def run_sources(sources) do
    sources
    |> Enum.map(fn source -> call_module_from_source(source) end)
    |> Enum.map(fn {response, source} -> store_snapshot(response, source) end)
  end

  def call_module_from_source(source) do
    method = String.to_atom(source.url)
    {apply(ApiList, method, []), source}
  end

  def store_snapshot(response, source) do
    Records.create_snapshot(%{url: source.url, type: "API", response: response, source_id: source.id, html: Jason.encode!(response)})
  end


end