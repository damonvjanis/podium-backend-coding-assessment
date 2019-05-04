defmodule PodiumWeb.PageController do
  use PodiumWeb, :controller

  def index(conn, _params) do
    reviews = Podium.get_reviews()
    render(conn, "index.html", reviews: reviews)
  end
end
