
`include "interface.sv"
`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  bit clk; // external signal declaration


  //----------------------------------------------------------------------------
  intf i_intf(clk);
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  FIFO_memory DUT(.din  (i_intf.din),
                  .read (i_intf.read),
                  .write(i_intf.write),
                  .reset(i_intf.reset),
                  .clk  (i_intf.clk),
                  .dout (i_intf.dout),
                  .full (i_intf.full),
                  .empty(i_intf.empty),
                  .ale  (i_intf.ale),
                  .alf  (i_intf.alf)
                   );
  //----------------------------------------------------------------------------               
  
  initial begin
    clk<=0;  
  end

  always #5 clk=~clk;
  
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("fifo_test");
  end
  //----------------------------------------------------------------------------
endmodule

