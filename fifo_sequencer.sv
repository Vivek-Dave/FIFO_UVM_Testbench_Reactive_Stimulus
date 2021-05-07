

class fifo_sequencer extends uvm_sequencer#(fifo_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(fifo_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="fifo_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:fifo_sequencer

