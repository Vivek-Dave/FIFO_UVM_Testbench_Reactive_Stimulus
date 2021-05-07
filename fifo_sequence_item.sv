`include "size.sv"
class fifo_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic [`DATA_WIDTH-1:0] din;  //i/p
  rand logic                  read;
  rand logic                 write;

  logic [`DATA_WIDTH-1:0]  dout;     //o/p
  logic                   empty;
  logic                    full;
  logic                     ale;
  logic                     alf;
  logic                    reset;
  
  //---------------- register fifo_sequence_item class with factory --------
  `uvm_object_utils_begin(fifo_sequence_item) 
      `uvm_field_int( din   ,UVM_ALL_ON)
      `uvm_field_int( read  ,UVM_ALL_ON)
      `uvm_field_int( write ,UVM_ALL_ON)

      `uvm_field_int( dout  ,UVM_ALL_ON)
      `uvm_field_int( empty ,UVM_ALL_ON)
      `uvm_field_int( full  ,UVM_ALL_ON)
      `uvm_field_int( ale   ,UVM_ALL_ON)
      `uvm_field_int( alf   ,UVM_ALL_ON)
      `uvm_field_int( reset ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="fifo_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("din=%2h  read=%0b write=%0b reset=%0b",din,read,write,reset));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("dout=%2h full=%0b alf=%0b empty=%0b ale=%0b ",dout,full,alf,empty,ale));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), "  ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:fifo_sequence_item
