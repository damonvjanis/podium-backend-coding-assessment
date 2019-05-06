defmodule Podium.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: PodiumWeb.Endpoint,
        options: [port: String.to_integer(System.get_env("PORT") || "4000")]
      )
    ]

    opts = [strategy: :one_for_one, name: Podium.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
