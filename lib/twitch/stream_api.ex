defmodule TwitchStream.StreamApi do
	use HTTPoison.Base

	def process_url(url) do
		"http://usher.twitch.tv/api/channel/hls" <> url
	end

	def get_stream_url(channel) do
		{sig, stream_token} = TwitchStream.Api.get_token(channel)
		IO.puts "sig: #{sig}"
		IO.puts "token: #{stream_token}"
		get!("/" <> channel <> ".m3u8", [], params: %{sig: sig, p: 12451, token: String.replace(stream_token, "\\", "")})
	end
end
