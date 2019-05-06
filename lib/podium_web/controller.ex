defmodule PodiumWeb.Controller do
  import Plug.Conn

  alias PodiumWeb.View

  def index(conn, _params) do
    reviews = Podium.get_reviews()
    render(conn, &View.index/1, %{reviews: reviews})
  end

  defp render(conn, template, assigns) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, template.(assigns))
  end
end
