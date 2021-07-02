defmodule Accretion.SSZ.Types.Misc do

  def eth1_data() do
    %{
      depositRoot: nil, #Bytes32
      depositCount: nil, #Number64
      blockHash: nil, #Bytes32,
    }
  end

  def signed_beacon_block_header() do
    %{
      message: nil, #BeaconBlockHeader
      signature: nil, #BLSSIgnature
    }
  end
end
