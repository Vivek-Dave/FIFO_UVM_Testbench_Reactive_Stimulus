
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "fifo_sequence_item.sv"        // transaction class
 `include "fifo_sequence.sv"             // sequence class
 `include "fifo_sequencer.sv"            // sequencer class
 `include "fifo_driver.sv"               // driver class
 `include "fifo_monitor.sv"
 `include "fifo_agent.sv"                // agent class  
 `include "fifo_coverage.sv"             // coverage class
 `include "fifo_env.sv"                  // environment class

 `include "fifo_test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


