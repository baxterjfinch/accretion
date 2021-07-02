defmodule Accretion.SSZ do
  require Logger

  def chain_head(block) do
    %{
      head_slot: block.head_slot,
      head_epoch: block.head_epoch,
      finalized_slot: block.finalized_slot,
      finalized_epoch: block.finalized_epoch,
      justified_slot: block.justified_slot,
      justified_epoch: block.justified_epoch,
      previous_justified_slot: block.previous_justified_slot,
      previous_justified_epoch: block.previous_justified_epoch,
      finalized_block_root: "0x#{Base.encode16(block.finalized_block_root)}",
      head_block_root: "0x#{Base.encode16(block.head_block_root)}",
      justified_block_root: "0x#{Base.encode16(block.justified_block_root)}",
      previous_justified_block_root: "0x#{Base.encode16(block.previous_justified_block_root)}",
    }
  end
end
