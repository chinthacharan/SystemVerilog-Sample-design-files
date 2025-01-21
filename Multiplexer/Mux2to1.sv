module mux2to1
#(parameter N = 4 ;)
 (input logic sel,
  input logic [N-1:0] a, b,
  output logic [N-1:0] y
 );

 timeunit 1ns/1ps;

 always_comb begin
    if(sel) y = a;
    else y = b;
 end
endmodule: mux2to1

