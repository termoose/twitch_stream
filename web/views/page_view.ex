defmodule TwitchStream.PageView do
  use TwitchStream.Web, :view

	def top_games do
		TwitchStream.Api.get_top_games
		|> Enum.map(&get_titles_and_pictures/1)
	end

	def get_titles_and_pictures(%{"game" => %{"name" => name, "box" => %{"medium" => picture}}}) do
		{name, picture}
	end

	def encode_url(url) do
		URI.encode(url)
	end
end
