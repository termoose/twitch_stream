defmodule TwitchStream.StreamApi do
	use HTTPoison.Base

	def process_url(url) do
		"http://usher.twitch.tv/api/channel/hls" <> url
	end

	def get_stream_url(channel) do
		url = "http://usher.twitch.tv/api/channel/hls/" <> channel <> ".m3u8"
		{sig, token} = TwitchStream.TokenApi.get_token(channel)
		query = %{"sig" => sig, "token" => token, "p" => "12451"}
		url <> "?" <> URI.encode_query(query)
	end
end
