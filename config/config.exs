# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :fun_with_flags, :persistence, adapter: FunWithFlags.Store.Persistent.InMemory

config :fun_with_flags, :cache_bust_notifications, enabled: false
