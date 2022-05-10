defmodule TestApi do

  def print_module do
    IO.inspect(__MODULE__)
  end

  def run(source) do
    {%{test: "a value", bob: "bill"}, source}
  end
end