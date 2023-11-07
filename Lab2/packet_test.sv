/*-----------------------------------------------------------------
File name     : packet_test.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab2 module for testing packet data
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

module packet_test;
import packet_pkg::*;

packet p;
bit ok;
// To test randomization, we edit packet_test.sv to randomize and print 
// 10 instances of packet
initial begin
  p = new("p",0);
  repeat (10) begin
    ok = p.randomize();
    p.print();
  end

// We can force a constraint violation by adding the inline constraint for 
// target = 4'hf and then print the packet
  ok = p.randomize() with {target == 4'hf;};
  p.print();
end

// Key point: when randomization fails, nothing is changed in the packet and it is as if 
// the randomization was never called

//--------------------validate functions for verification --------------------

function int countones (input logic[3:0] vec);
  countones = 0;
  foreach (vec [i])
    if (vec[i]) countones++;
endfunction

function void validate (input packet ap);
  int sco, tco;
  sco = countones(ap.source);
  tco = countones(ap.target);
  if (sco != 1) 
     $display("ERROR in source %h - no. bits set = %0d", ap.source, sco);
  if (ap.ptype == "broadcast") begin
    if  (ap.target != 4'hf) 
       $display("ERROR: broadcast packet target is %h not 4'hf", ap.target);
  end
  else 
  begin
    if ( |(ap.source & ap.target) == 1'b1)   
      $display("ERROR: non-broadcast packet %s has same source %h and target %h bit set", ap.getname(), ap.source, ap.target);
    if ((ap.ptype == "single") & (tco != 1)) 
      $display("ERROR: single packet %s does not have only one bit set in target %h", ap.getname(), ap.target);
    if ((ap.ptype == "multicast") & (tco < 2)) 
      $display("ERROR: multicast packet %s does not have more than one bit set in target %h", ap.getname(), ap.target);
  end
endfunction
    
endmodule
   

