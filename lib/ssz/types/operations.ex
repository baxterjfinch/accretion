defmodule Accretion.SSZ.Types.Operations do

  def proposer_slashings() do
    %{
      signedHeader1: nil, #Bytes32
      signedHeader2: nil, #Number64
    }
  end
end
