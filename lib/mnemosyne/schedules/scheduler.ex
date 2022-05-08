defmodule Mnemosyne.Scheduler do
  use Quantum, otp_app: :mnemosyne

  alias Mnemosyne.Records

  def run_every_min do
    sources = Records.all_sources()
    ScrapeFromSource.run_sources(sources)
  end

end