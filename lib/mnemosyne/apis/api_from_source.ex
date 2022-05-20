defmodule ApiFromSource do

  alias Mnemosyne.Records

  def run_sources(sources) do
    sources
    |> Enum.map(fn source -> call_module_from_source(source) end)
    |> Enum.map(fn {response, source} -> store_snapshot(response, source) end)
  end

  def call_module_from_source(source) do
#    method = String.to_atom(source.url)
#    {apply(ApiList, method, []), source}
# Testing
    res = ApiList.test_localhost(source.url)
    IO.inspect(res)
    {res, source}
  end

  def store_snapshot(response, source) do
    Records.create_snapshot(%{url: source.url, type: "API", response: response, source_id: source.id, html: Jason.encode!(response)})
  end

  def test_sources do
    sources = create_test_sources(30)

    {uSecs, _res} = :timer.tc(fn -> flow_sources(sources) end)
    uSecs / 1_000_000


  end

  defp flow_sources(sources) do
    sources
    |> Flow.from_enumerable(max_demand: 4)
    |> Flow.map(fn source -> call_module_from_source(source) end)
    |> Flow.map(fn {response, source} -> store_snapshot(response, source) end)
    |> Enum.to_list
  end

  defp create_test_sources(n) do
    1..n
    |> Enum.map(fn n -> %{url: "http://localhost:4000/api/test/#{n}", id: 2} end)
  end


end