defmodule HerminioTorresWeb.Presence do
  use Phoenix.Presence,
    otp_app: :herminio_torres,
    pubsub_server: HerminioTorres.PubSub
end
