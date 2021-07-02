defmodule Accretion.Util.ByteArray do
  require Logger

  @hexByByte

  def to_hex_string(bytes) do
    hex = "0x";
    Logger.debug("Bytes: #{inspect :binary.bin_to_list(bytes)}")

    for byte <- :binary.bin_to_list(bytes) do
      # Logger.debug("Byte: #{byte}")
      # if (!@hexByByte[byte]) {
      #   @hexByByte[byte] = byte < 16 ? "0" + byte.toString(16) : byte.toString(16);
      # }
      # hex += @hexByByte[byte];
    end

    for <<byte <- bytes>> do
      # Logger.debug("Byte: #{byte}")

    end
  end
end
