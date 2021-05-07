
class fifo_env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(fifo_env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="fifo_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
  fifo_agent    agent_h;
  fifo_coverage coverage_h;
  //fifo_scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h    = fifo_agent::type_id::create("agent_h",this);
    coverage_h = fifo_coverage::type_id::create("coverage_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);
    // make scoreboard connection here
  endfunction
  //----------------------------------------------------------------------------
endclass:fifo_env

