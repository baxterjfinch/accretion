import Config

config :logger, :console,
  format: "$date $time [$level] $message\n"

config :accretion,
  beacon_host: "192.168.1.195",
  beacon_port: 4000,
  grpc_retry: 3
