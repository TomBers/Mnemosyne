defmodule Mnemosyne.Scheduler do
  use Quantum, otp_app: :mnemosyne

  alias Mnemosyne.Records

  def run_every_min do
#    TODO - split sources into Scraper and API
#    ScrapeFromSource.run_sources(Records.all_scraper_sources())
    ApiFromSource.run_sources(Records.all_api_sources())

  end

end