# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hello_context,
  ecto_repos: [HelloContext.Repo]

# Configures the endpoint
config :hello_context, HelloContextWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "USmbeiKz/h/1LE4S2BcGSVgq8BFKF4x1XC0/V+N8CYbI1UlpnMWztI3ccAUZ4vY9",
  render_errors: [view: HelloContextWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HelloContext.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
