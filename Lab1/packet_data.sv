/*-----------------------------------------------------------------
File name     : packet_data.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab1 packet data class
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

  // print policy for formatting packet print
 typedef enum {HEX,BIN,DEC} pp_t;
 typedef enum {ANY, SINGLE, MULTICAST, BROADCAST} ptype_t;

// packet class
class packet;

  local string name;

  bit [3:0] target;
  bit [3:0] source;
  bit [7:0] data;
  ptype_t ptype; 
// ptype debug property of type ptype_t which is declared outside the class as an enum

  // constructor sets source and packet type


  function new ( string name, int idt); // instance name argument and an argument idt for the source.
    this.name = name;
    source = 1 << idt; // idt will be in the range 0 to 3 --> converted that the 4-bit one-hot-encoding required for source using a left shift
    ptype = ANY; // ptype to ANY as default
  endfunction

  function string getname();
      return name;
  endfunction
 
  // get packet type
  function string gettype();
      return ptype.name();
  endfunction
 
 // print with policy
  function void print(input pp_t pp = DEC);
    $display("----------------------------------");
    $display("name: %s, type: %s",getname(), gettype());
    case (pp)
      HEX: $display("from source %h, to target %h, data %h",source,target,data);
      DEC: $display("from source %0d, to target %0d, data %0d",source,target,data);
      BIN: $display("from source %b, to target %b, data %b",source,target,data);
    endcase
    $display("----------------------------------\n");
  endfunction

endclass

