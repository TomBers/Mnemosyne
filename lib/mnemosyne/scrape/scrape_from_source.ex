defmodule ScrapeFromSource do

  import Ecto

  def run_source(source) do
#    IO.inspect("#{__MODULE__}")
#    IO.inspect(source.url)
    urls = [
      source.url
    ]

    Crawly.Engine.start_spider(Spider, urls: urls, crawl_id: source.id)
  end

  def run_sources(sources) do
    uuid = Ecto.UUID.generate
    urls = sources |> Enum.map(fn source -> source.url end)
#    TODO - log attempt - se we can track what crawls failed?
    Crawly.Engine.start_spider(Spider, urls: urls, crawl_id: uuid)

  end

end