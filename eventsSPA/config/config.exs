# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eventsSPA,
  ecto_repos: [EventsSPA.Repo]
  #mix_env: "#{Mix.env()}"

# Configures the endpoint
config :eventsSPA, EventsSPAWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Z4C7ZX3VKdyh1igA+hpJVQ66E3P1fiLvHnw02DLz/q2ucsTR1xzVHq7PPQaFb4y/",
  render_errors: [view: EventsSPAWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EventsSPA.PubSub,
  live_view: [signing_salt: "QsLb6CUA"]


# config :cors_plug,
#   origin: ["http://localhost:3000"],
#   max_age: 86400,
#   methods: ["GET", "POST", "PATCH", "DELETE"],
#   headers: ["x-auth"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
