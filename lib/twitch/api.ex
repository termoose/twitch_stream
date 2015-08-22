defmodule TwitchStream.Api do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, [], [name: __MODULE__])
	end

	def get_stream_playlist(channel) do
		GenServer.call(__MODULE__, {:stream_url, channel})
	end

	def get_top_games do
		GenServer.call(__MODULE__, :top_games)
	end

	def get_streams(game) do
		GenServer.call(__MODULE__, {:streams, game})
	end

	def get_token(channel) do
		GenServer.call(__MODULE__, {:token, channel})
	end

	# Server callbacks
	def handle_call(:top_games, _from, response) do
		case ExRated.check_rate("twitch_top_games", 60_000, 1) do
			{:ok, _n} ->
				api_response = TwitchStream.TwitchApi.get_top_games
				{:reply, api_response, api_response}
																														
			{:fail, _n} ->
				IO.puts "Using cached top Twitch games"
				{:reply, response, response}
		end
	end

	def handle_call({:streams, game_name}, _from, response) do
		case ExRated.check_rate("twitch_streams_" <> game_name, 60_000, 1) do
			{:ok, _n} ->
				api_response = TwitchStream.TwitchApi.get_streams(game_name)
				{:reply, api_response, api_response}

			{:fail, _n} ->
				IO.puts "Using cached stream names"
				{:reply, response, response}
		end
	end

	def handle_call({:token, channel}, _from, response) do
		case ExRated.check_rate("twitch_token_" <> channel, 60_000, 1) do
			{:ok, _n} ->
				api_response = TwitchStream.TokenApi.get_token(channel)
				{:reply, api_response, api_response}

			{:fail, _n} ->
				IO.puts "Using cached token"
				{:reply, response, response}
		end
	end

	def handle_call({:stream_url, channel}, _from, response) do
		case ExRated.check_rate("twitch_stream_" <> channel, 60_000, 1) do
			{:ok, _n} ->
				api_response = TwitchStream.StreamApi.get_stream_url(channel)
				{:reply, api_response, api_response}

			{:fail, _n} ->
				IO.puts "Using cached stream URL"
				{:reply, response, response}
		end
	end
end
