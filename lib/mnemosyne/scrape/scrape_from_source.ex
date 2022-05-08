defmodule ScrapeFromSource do

  def run_source(source) do
#    IO.inspect("#{__MODULE__}")
#    IO.inspect(source.url)
    urls = [
      source.url
    ]

    Crawly.Engine.start_spider(Spider, urls: urls, crawl_id: source.id)

  end

end