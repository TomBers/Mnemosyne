defmodule PipelineStoreDb do
	
	def run(item, state, opts \\ []) do
		IO.inspect(item)
		# Use Jason.decode!(item) to get a map (it is JSON encoded)
		
		# TODO write jobs to the DB
		
		IO.inspect(state)
		IO.inspect(opts)	
		
		# To Save HTML
		# response = Crawly.fetch("https://www.autotrader.co.uk/cars/leasing/product/202110278946696")
		# File.write(“/tmp/nissan_splash.html”, response.body)
		{item, state}  
	end
end