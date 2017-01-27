# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sheriff_example_app,
  ecto_repos: [SheriffExampleApp.Repo]

# Configures the endpoint
config :sheriff_example_app, SheriffExampleApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nQT22amhqxNXmmfeuzULOgBcX3W5yQMkRnqOwfsuDqL6wydMERNJKXc3DAoEaDND",
  render_errors: [view: SheriffExampleApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SheriffExampleApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "SheriffExampleApp",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "some_secret_key",
  serializer: SheriffExampleApp.GuardianSerializer

config :sheriff, Sheriff,
  handler: SheriffExampleApp.AuthHandler,
  loader: SheriffExampleApp.UserLoader,
  resource_key: :guardian_default_resource

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
