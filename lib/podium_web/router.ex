defmodule PodiumWeb.Router do
  use Plug.Router

  alias PodiumWeb.Controller

  plug(:match)
  plug(:dispatch)

  get "/" do
    Controller.index(conn, conn.params)
  end

  match _ do
    send_resp(conn, 404, "page not found")
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "something went wrong")
  end
end
