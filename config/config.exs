# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qYyxeewZSskpTZUPU1ia7/NSfhn5ZRNV7xPkp0sx4BWrVDfdAEPCL3JTOFEqvgCu",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "Sn84S7BvdyF33C80PkB0YTSUtmMW2N0P"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use LiveView templates
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# https://elixirschool.com/blog/phoenix-live-view/


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
