defmodule TwitchStream.TwitchApi do
	use HTTPoison.Base
	
	def process_url(url) do
		"https://api.twitch.tv/kraken" <> url
	end

	def process_response_body(body) do
		body
		|> Poison.decode!
		|> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
	end

	def get_top_games do		
		get!("/games/top").body[:top]
	end

	def get_streams(game_name) do
		get!("/streams", [], params: %{game: game_name}).body[:streams]
	end
end
