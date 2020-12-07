# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :loom, Loom.Astra,
  username: System.get_env("ASTRA_USERNAME"),
  password: System.get_env("ASTRA_PASSWORD"),
  id: System.get_env("ASTRA_ID"),
  region: "us-east1",
  keyspace: "loom"

config :loom, :strategies,
  google: [
    client_id: System.get_env("GOOGLE_CLIENT_ID"),
    client_secret: System.get_env("GOOGLE_CLIENT_SECRET")
  ]

config :loom, LoomWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "80")],
  secret_key_base: secret_key_base,
  https: [
    port: String.to_integer(System.get_env("SSL_PORT") || "443"),
    cipher_suite: :strong,
    otp_app: :loom,
    keyfile: System.get_env("LOOM_SSL_KEY_PATH"),
    certfile: System.get_env("LOOM_SSL_CERT_PATH"),
    cacertfile: System.get_env("LOOM_SSL_CA_CERT_PATH")
  ]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :loom, LoomWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.