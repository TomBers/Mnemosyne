defmodule ApiFromSource do

  alias Mnemosyne.Records

  def run_sources(sources) do
    sources
    |> Flow.from_enumerable(max_demand: 4)
    |> Flow.map(fn source -> Task.start_link(fn -> make_and_store_request(source) end) end)
    |> Enum.to_list
  end

  def make_and_store_request(source) do
    method = String.to_atom(source.url)
    response = apply(ApiList, method, [])
    Records.create_snapshot(%{url: source.url, type: "API", response: response, source_id: source.id, html: Jason.encode!(response)})
  end

end