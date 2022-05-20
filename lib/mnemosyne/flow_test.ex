defmodule FlowTest do

  def run do
    sources = 1..128 |> Enum.map(fn x -> "batch #{x}" end)

    {uSecs, _res} = :timer.tc(fn -> flow_n(sources) end)
    uSecs / 1_000_000
  end

  def flow_n(sources) do
    num_batches = 3
    mx_demand = div(length(sources), num_batches)
    IO.inspect(mx_demand)
    IO.inspect(div(mx_demand, 2))


#    min_demand: div(n, 2), max_demand: n - splits the batch into 2
    sources
    |> Flow.from_enumerable(min_demand: div(mx_demand, 2), max_demand: mx_demand)
    |> Flow.map_batch(fn x -> slow_func(x) end)
    |> Enum.to_list
  end

  def run_n(n) do
    1..n
    |> Enum.map(fn x -> slow_func(x) end)
  end

  def slow_func(x) do
    :timer.sleep(1500)
    IO.inspect(x)
  end

end