defmodule DraftApiFromSource do
#  An experimental playground using Flow

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
    |> Flow.map(fn source -> Task.start_link(fn -> make_and_store_request(source) end) end)
    |> Enum.to_list
  end

  def make_and_store_request(source) do
    response = ApiList.test_localhost(source.url)
    Records.create_snapshot(%{url: source.url, type: "API", response: response, source_id: source.id, html: Jason.encode!(response)})
  end

#  defp flow_sources(sources) do
#
##    Note - for some reason max_demand: 4 works best - not sure why - did 30 requests with a 2 sec time out in 8 secs
##    Idea - machine has 8 threads - we have 30 jobs - so 4 jobs on each thread - gives 4 * 2 secs = 8 secs
##    To test - if we have 5 jobs to a queue - the slowest thread will end in 5 * 2 = 10 secs - result 10.397162 secs
##    If we have max demand 3 - then we have to get another batch so (3 * 2) * 2 = 12 secs
#
#    sources
#    |> Flow.from_enumerable(max_demand: 3)
#    |> Flow.map(fn source -> call_module_from_source(source) end)
#    |> Flow.map(fn {response, source} -> store_snapshot(response, source) end)
#    |> Enum.to_list
#  end

  defp create_test_sources(n) do
    1..n
    |> Enum.map(fn n -> %{url: "http://localhost:4000/api/test/#{n}", id: 2} end)
  end


end