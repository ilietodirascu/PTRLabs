defmodule Quotes do
  def launch do
    response = HTTPoison.get!("https://quotes.toscrape.com/")
    get_request_info(response)
    quotes = get_quotes(response.body)
    save_json(quotes)
  end
  def get_request_info(response) do
    IO.puts(response.body)
    IO.puts("Status code: #{response.status_code}")
    IO.inspect(response.headers)
  end
  def get_quotes(body) do
    Floki.find(body,".quote")
    |> Enum.map(&(%{
      quote: get_quote_text(&1),
      author: get_author(&1),
      tags: get_tags(&1)
    }))
  end
  def get_quote_text(div) do
    Floki.find(div,".text")
    |> Floki.text()
  end
  def get_author(div) do
    Floki.find(div,".author")
    |> Floki.text()
  end
  def get_tags(div) do
    Floki.find(div,".tag")
    |> Enum.map(&(Floki.text(&1)))
  end
   def save_json(quotes) do
    data = Jason.encode!(quotes) |> Jason.Formatter.pretty_print()
    File.write!("quotes.json", data)
  end
end
