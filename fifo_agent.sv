
class fifo_agent extends uvm_agent;

  //----------------------------------------------------------------------------
  `uvm_component_utils(fifo_agent)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="fifo_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //----------------- class handles --------------------------------------------
  fifo_sequencer sequencer_h;
  fifo_driver    driver_h;
  fifo_monitor   monitor_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver_h    = fifo_driver::type_id::create("driver_h",this);
    sequencer_h = fifo_sequencer::type_id::create("sequencer_h",this);
    monitor_h   = fifo_monitor::type_id::create("monitor_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------- connect phase --------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction
  //----------------------------------------------------------------------------

endclass:fifo_agent

