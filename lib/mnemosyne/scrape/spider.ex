defmodule Spider do
  use Crawly.Spider

	alias Mnemosyne.Records

  # This is not going to be used, so we're ignoring it.
  @impl Crawly.Spider
  def base_url() do
	:ok
  end

  @impl Crawly.Spider
  def init(options) do
	[start_urls: Keyword.get(options, :urls)]
  end

  @impl Crawly.Spider
  def parse_item(response) do
	# First of all lets find a host, as it will allow us to match the parsing rule
	#	parsed_uri = URI.parse(response.request_url)

	source = Records.get_source_by_url!(response.request_url)

	{:ok, document} = Floki.parse_document(response.body)

	item =
		source.page_elements
		|> Enum.flat_map(fn(%{"element" => ele, "name" => name}) -> find_item(document, name, ele) end)
		|> Map.new()
		|> Map.put(:url, response.request_url)
		|> Map.put(:source, source)


	%{
	  :requests => [],
	  :items => [item]
	}
  end

  # Item parse for hemnet.se
  defp find_item(document, name, ele) do
	txt =
	  document
	  |> Floki.find(ele)
	  |> Floki.text()

	Map.put(%{}, String.to_atom(name), txt)
  end

end