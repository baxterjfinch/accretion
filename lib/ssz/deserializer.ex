defmodule Accretion.SSZ do
  require Logger

  def deserialize_block(block) do
    # Logger.info("Deserializing: #{inspect block}")
    Accretion.Util.ByteArray.to_hex_string(block.finalized_block_root)
  end
end
