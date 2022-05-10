defmodule PipelineStoreDb do
	alias Mnemosyne.Records
	
	def run(item, state, _opts \\ []) do
#		IO.inspect("#{__MODULE__}")
#		IO.inspect(item)
		# Use Jason.decode!(item) to get a map (it is JSON encoded)

		{source, item} = Map.pop(item, :source)
		{url, item} = Map.pop(item, :url)

		response = Crawly.fetch(url)
		new_snapshot = %{url: url, type: "WebScraper", response: item, source_id: source.id, html: response.body}

		Records.create_snapshot(new_snapshot)

		# To Save HTML
		# response = Crawly.fetch("https://www.autotrader.co.uk/cars/leasing/product/202110278946696")
		# File.write(“/tmp/nissan_splash.html”, response.body)
		{item, state}  
	end
end