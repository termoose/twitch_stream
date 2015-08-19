defmodule TwitchStream.PageController do
  use TwitchStream.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
