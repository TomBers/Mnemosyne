defmodule Homebase do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.homebase.co.uk"

  @impl Crawly.Spider
  def init() do
	[
	  start_urls: [
		"https://www.homebase.co.uk/our-range/tools"
	  ]
	]
  end

  @impl Crawly.Spider
  def parse_item(_response) do
	%Crawly.ParsedItem{:items => [], :requests => []}
  end
end