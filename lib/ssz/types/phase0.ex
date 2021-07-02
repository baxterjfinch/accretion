defmodule Accretion.SSZ.Types.Phase0 do

  def beacon_block_body() do
    %{
      randaoReveal: nil, #Bytes96
      eth1Data: nil, #./misc/eth1_data
      graffiti: nil, #Bytes32,
      proposerSlashings: nil, #List<ProposerSlashing>
      attesterSlashings: nil, #List<AttesterSlashing>;
      attestations: nil, #List<Attestation>
      deposits: nil, #<Deposit>
      voluntaryExits: nil #SignedVoluntaryExit>
    }
  end
end
