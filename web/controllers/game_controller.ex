defmodule TwitchStream.GameController do
	use TwitchStream.Web, :controller

	def index(conn, %{"game" => game, "streamer" => streamer}) do
		render conn, "stream.html", game_name: game, streamer_name: streamer
	end

	def index(conn, %{"game" => game}) do
		render conn, "index.html", game_name: game
	end
end
