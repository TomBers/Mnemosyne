defmodule ApiList do

  def test_simple do
    case HTTPoison.get("https://api.chucknorris.io/jokes/random") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> Jason.decode!(body)
      _ -> :error
    end
  end

  def test_localhost(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> Jason.decode!(body)
      _ -> :error
    end
  end

end