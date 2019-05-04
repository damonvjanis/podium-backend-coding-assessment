use Mix.Config

# Configures the endpoint
config :podium, PodiumWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FnHQWWkauYY7XcdKt+medXTIn/Hy47AV2uxna+bZhWQjQM+2bA/mSPINinbMRGfT",
  render_errors: [view: PodiumWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Podium.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
