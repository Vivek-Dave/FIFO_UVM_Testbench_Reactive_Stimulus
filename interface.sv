`include "size.sv"
interface intf(input bit clk);
    // ------------------- port declaration-------------------------------------
    logic reset;                  // i/p to DUT
    logic [`DATA_WIDTH-1:0] din;  // i/p to DUT
    logic read;                   // i/p to DUT 
    logic write;                  // i/p to DUT

    logic [`DATA_WIDTH-1:0] dout; // o/p of DUT
    logic empty;                  // o/p of DUT 
    logic full;                   // o/p of DUT
    logic alf;                    // o/p of DUT
    logic ale;                    // o/p of DUT
    //--------------------------------------------------------------------------

    //------------- clocking & modport declaration -----------------------------
    clocking cb @(posedge clk);
      default input #1step output #(`Tdelay);
      output reset,din,read,write;     //input  of DUT
      input  dout,empty,full,alf,ale;  //output of DUT
    endclocking
  
    //modport modport_name(clocking name_of_block);
    //--------------------------------------------------------------------------
        
endinterface
