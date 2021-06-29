defmodule Accretion.BeaconClient do
  @moduledoc """
  grpc client that handles beacon chain calls
  """
  use GenServer
  require Logger

  @name __MODULE__
  @beacon_host Application.get_env(:accretion, :beacon_host)
  @beacon_port Application.get_env(:accretion, :beacon_port)
  @grpc_retry Application.get_env(:accretion, :grpc_retry)

  # Client methods
  def start_link(_) do
    {:ok, channel} =
      GRPC.Stub.connect("#{@beacon_host}:#{@beacon_port}",
        adapter_opts: %{
          http2_opts: %{keepalive: 10000}
        }
      )

    Logger.metadata(endpoint: "#{@beacon_host}:#{@beacon_port}")
    Logger.info("Starting gRPC connection to beacon node")
    GenServer.start_link(@name, channel, name: @name)
  end

  # Server methods
  @impl true
  def init(channel) do
    GenServer.cast(@name, {:sync_status})
    # GenServer.cast(@name, {:list_peers})
    GenServer.cast(@name, {:stream_chain_head})
    {:ok, channel}
  end

  @impl true
  def handle_cast({:sync_status}, channel) do
    req = Google.Protobuf.Empty.new()
    case channel |> Ethereum.Eth.V1alpha1.Node.Stub.get_sync_status(req) do
      {:ok, status} ->
        Logger.info("Sync Status: #{inspect status}")

        # Enum.each(stream, fn {:ok, block} ->
        #   FinalMix.Watcher.stream_block(block)
        # end)

      {:error, err} ->
        Logger.info("ERR: #{inspect err}")

        IO.inspect(err)
    end

    {:noreply, channel}
  end

  @impl true
  def handle_cast({:list_peers}, channel) do
    req = Google.Protobuf.Empty.new()
    case channel |> Ethereum.Eth.V1alpha1.Node.Stub.list_peers(req) do
      {:ok, peers} ->
        Logger.info("Peers: #{inspect peers}")

      {:error, err} ->
        Logger.info("ERR: #{inspect err}")

        IO.inspect(err)
    end

    {:noreply, channel}
  end

  @impl true
  def handle_cast({:stream_chain_head}, channel) do
    req = Google.Protobuf.Empty.new()
    case channel |> Ethereum.Eth.V1alpha1.BeaconChain.Stub.stream_chain_head(req) do
      {:ok, stream} ->
        Enum.each(stream, fn {:ok, head} ->
          Logger.info("STREAM: #{inspect head}")
        end)
      {:error, err} ->
        Logger.info("ERR: #{inspect err}")
        IO.inspect(err)
    end

    {:noreply, channel}
  end
end
