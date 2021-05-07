
class fifo_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(fifo_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="fifo_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  fifo_sequence_item  tr;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(fifo_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    tr=fifo_sequence_item::type_id::create("tr");
    forever
    begin
      sample_dut(tr);
      `uvm_info(get_type_name(),tr.convert2string(),UVM_MEDIUM)
      ap_mon.write(tr);
    end
  endtask
  //----------------------------------------------------------------------------

    task sample_dut(output fifo_sequence_item tr);
		fifo_sequence_item t=fifo_sequence_item::type_id::create("t");
		//--------------------------------------------------------
		// Sample DUT synchronous inputs on posedge clk.
		// DUT inputs should have been valid for most
		// of the previous clock cycle
		//--------------------------------------------------------
		t.din    = vif.din;
		t.read   = vif.read;
		t.write  = vif.write;
		t.reset  = vif.reset;
		//--------------------------------------------------------
		// Wait for posdege clk and sample outputs #1step before.
		//--------------------------------------------------------
		@vif.cb;	
		t.dout  = vif.cb.dout;
      	t.full  = vif.cb.full;
      	t.alf   = vif.cb.alf;
      	t.empty = vif.cb.empty;
      	t.ale   = vif.cb.ale;
		//--------------------------------------------------------
		tr=t;
	endtask



endclass:fifo_monitor

