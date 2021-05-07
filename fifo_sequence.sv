
/***************************************************
** class name  : fifo_sequence
** description : will write,read in fifo using 
                 reactive stimulus
***************************************************/
class fifo_sequence extends uvm_sequence#(fifo_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(fifo_sequence)            
  //----------------------------------------------------------------------------

  
  fifo_sequence_item txn=fifo_sequence_item::type_id::create("txn");
  fifo_sequence_item rsp;

  //----------------------------------------------------------------------------
  function new(string name="fifo_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    
    repeat(2)  task_reset(txn);
    write_until_full(txn);
    read_until_empty(txn);
    write_until_alf(txn);
    read_until_ale(txn);
    repeat(2)  task_reset(txn);
    //repeat(50) random(txn);
    repeat(2) write(txn);
    fifo_read_write_same_time(txn); // it iterates 20 times see task definition
    //command1();
    //command2();
  endtask:body
  //----------------------------------------------------------------------------
  task task_reset(fifo_sequence_item txn);
    `uvm_info("body","\n --------------- Reset ---------------",UVM_HIGH)
    start_item(txn);
    txn.din=0;
    txn.read=0;
    txn.write=0;
    txn.reset=1;
    finish_item(txn);
    get_response(rsp);
  endtask

  task write(fifo_sequence_item txn);
    start_item(txn);
    txn.randomize()with{txn.write==1; txn.read==0;};
    txn.reset=0;
    finish_item(txn);
    get_response(rsp);
  endtask

  task read(fifo_sequence_item txn);
    start_item(txn);
    txn.randomize()with{txn.write==0; txn.read==1;};
    txn.reset=0;
    finish_item(txn);
    get_response(rsp);
  endtask

  task write_until_full(fifo_sequence_item txn);
    `uvm_info("body","\n Starting write_until_full ",UVM_HIGH)
    while(!rsp.full) write(txn);
  endtask

  task write_until_alf(fifo_sequence_item txn);
    `uvm_info("body","\n Starting write_until_alf ",UVM_HIGH)
    while(!rsp.alf) write(txn);
  endtask

  task read_until_empty(fifo_sequence_item txn);
    `uvm_info("body","\n Starting read_until_empty ",UVM_HIGH)
    while(!rsp.empty) read(txn);
  endtask

  task read_until_ale(fifo_sequence_item txn);
    `uvm_info("body","\n Starting write_until_ale ",UVM_HIGH)
    while(!rsp.ale) read(txn);
  endtask

  task random(fifo_sequence_item txn);
    `uvm_info("body","\n Starting random stimulus ",UVM_HIGH)
    start_item(txn);
    txn.randomize();
    txn.reset=0;
    finish_item(txn);
    get_response(rsp);
  endtask
  
  task read_write_same_time(fifo_sequence_item txn);
    start_item(txn);
    txn.randomize()with{txn.read==1; txn.write==1;};
    txn.reset=0;
    finish_item(txn);
    get_response(rsp);
  endtask
  
  task fifo_read_write_same_time(fifo_sequence_item txn);
    static int i=0;
    `uvm_info("body","\n Staering fifo_read_writr_same_time",UVM_HIGH)
    for(i=0;i<20;i++) begin
      if(rsp.full==0 && rsp.empty==0) read_write_same_time(txn);
      else break;
    end
    //while(rsp.full==0 && rsp.empty==0) read_write_same_time(txn);
  endtask
  
  

endclass:fifo_sequence

// /***************************************************
// ** class name  :
// ** description :
// ***************************************************/
// class sequence_name_1 extends fifo_sequence;
//   //----------------------------------------------------------------------------   
//   `uvm_object_utils()      
//   //----------------------------------------------------------------------------
  
//   fifo_sequence_item txn;
  
//   //----------------------------------------------------------------------------
//   function new(string name="");
//       super.new(name);
//   endfunction
//   //----------------------------------------------------------------------------
  
//   //----------------------------------------------------------------------------
//   task body();
//     txn=fifo_sequence_item::type_id::create("txn");
//     start_item(txn);
//     txn.randomize();
//     finish_item(txn);
//   endtask:body
//   //----------------------------------------------------------------------------
  
// endclass

// /***************************************************
// ** class name  :
// ** description :
// ***************************************************/
// class sequence_name_2 extends fifo_sequence;
//   //----------------------------------------------------------------------------   
//   `uvm_object_utils()      
//   //----------------------------------------------------------------------------
  
//   fifo_sequence_item txn;
  
//   //----------------------------------------------------------------------------
//   function new(string name="");
//       super.new(name);
//   endfunction
//   //----------------------------------------------------------------------------
  
//   //----------------------------------------------------------------------------
//   task body();
//     txn=fifo_sequence_item::type_id::create("txn");
//     start_item(txn);
//     txn.randomize();
//     finish_item(txn);
//   endtask:body
//   //----------------------------------------------------------------------------
  
// endclass


// class sequence_name_3 extends fifo_sequence;
//   //----------------------------------------------------------------------------   
//   `uvm_object_utils()      
//   //----------------------------------------------------------------------------
  
//   fifo_sequence_item txn;
  
//   //----------------------------------------------------------------------------
//   function new(string name="");
//       super.new(name);
//   endfunction
//   //----------------------------------------------------------------------------
  
//   //----------------------------------------------------------------------------
//   task body();
//     txn=fifo_sequence_item::type_id::create("txn");
//     start_item(txn);
//     txn.randomize();
//     finish_item(txn);
//   endtask:body
//   //----------------------------------------------------------------------------
  
// endclass

 