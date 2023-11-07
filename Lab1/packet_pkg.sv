/*-----------------------------------------------------------------
File name     : packet_p.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab1 packet data package
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

//For initial testing, we declare a package in the file packet_pkg.sv which just  includes the packet_data.sv file.

package packet_pkg;

`include "packet_data.sv"

endpackage
