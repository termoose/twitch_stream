defmodule TwitchStream.GameView do
	use TwitchStream.Web, :view

	def get_streams(game) do
		TwitchStream.Api.get_streams(game)
		|> Enum.map(&get_stream_info/1)
	end

	def get_playlist(channel) do
		TwitchStream.Api.get_stream_playlist(channel)
	end
	
	def get_stream_info(%{"channel" => %{"name" => name, "status" => status},	"preview" => %{"medium" => image}}) do
		{name, status, image}
	end

	def get_stream_info(%{"channel" => %{"name" => name, "bio" => status},	"preview" => %{"medium" => image}}) do
		{name, status, image}
	end

end
