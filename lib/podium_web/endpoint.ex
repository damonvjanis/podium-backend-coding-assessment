defmodule PodiumWeb.Endpoint do
  use Plug.Builder
  if Mix.env() == :dev, do: use Plug.Debugger, otp_app: :podium
  use Plug.ErrorHandler

  plug(Plug.SSL, rewrite_on: [:x_forwarded_proto])
  plug(Plug.Static, at: "/", from: :podium, gzip: false, only: ~w(favicon.ico robots.txt))
  plug(Plug.RequestId)
  plug(Plug.Logger)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(Plug.Head)
  plug(Plug.Session, store: :cookie, key: "_podium_key", signing_salt: "g8YgL3uw")
  plug(:fetch_session)
  plug(Plug.CSRFProtection)
  plug(PodiumWeb.Router)
end
