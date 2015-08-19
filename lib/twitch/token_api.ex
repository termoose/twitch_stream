defmodule TwitchStream.TokenApi do
	use HTTPoison.Base

	def process_url(url) do
		"http://api.twitch.tv/api/channels/"<> url <>"/access_token"
	end

	def process_response_body(body) do
		body
		|> Poison.decode!
		|> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
	end

	def get_token(channel) do
		response = get!(channel).body

		{response[:sig], response[:token]}
	end
end
