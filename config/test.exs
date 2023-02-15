import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pk_message, PkMessageWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jPx6+yeD/8vAa3bB9krm9/gQ73LSGuR61QovGq+yLehBwfoNabsOXT2brFBE9LrX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
