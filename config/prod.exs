use Mix.Config

config :podium, PodiumWeb.Endpoint,
  url: [scheme: "https", host: "damon-podium.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Do not print debug messages in production
config :logger, level: :info

import_config "prod.secret.exs"
