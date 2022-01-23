import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :herminio_torres, HerminioTorresWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ifXdvbeW9cQ8CjvdH1eOFeSNs20y+O6ki/a/g/eXjWy1f1QZZiESU8rtkeFx4WnJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
