
class fifo_driver extends uvm_driver #(fifo_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(fifo_driver)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="fifo_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

 
  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    fifo_sequence_item txn=fifo_sequence_item::type_id::create("txn");
    fifo_sequence_item rsp;
    initialize();
    forever begin
      seq_item_port.get_next_item(txn);
      drive_item(txn,rsp);
      rsp.set_id_info(txn);
      seq_item_port.item_done(rsp);    
    end
  endtask
  //----------------------------------------------------------------------------
  
  task drive_item(fifo_sequence_item tr,output fifo_sequence_item rsp);
    fifo_sequence_item resp;
    if(!$cast(resp,tr.clone())) `uvm_fatal("Driver","ERROR");
    vif.cb.reset <= tr.reset;
    vif.cb.din   <= tr.din;
    vif.cb.write <= tr.write;
    vif.cb.read  <= tr.read;
    @vif.cb;
    // copy all outputs at the end of cycle to resp
    resp.full  = vif.cb.full;
    resp.alf   = vif.cb.alf;
    resp.empty = vif.cb.empty;
    resp.ale   = vif.cb.ale;
    resp.dout  = vif.cb.dout;
    rsp=resp;
  endtask

  task initialize();
    vif.din   <=0;
    vif.read  <=0;
    vif.write <=0;
    vif.reset <=1;
  endtask

endclass:fifo_driver