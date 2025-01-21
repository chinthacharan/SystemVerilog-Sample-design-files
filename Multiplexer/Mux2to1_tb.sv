module test
#(parameter N = 4;)
 (output logic sel,
  output logic [N-1:0] a, b,
  input logic [N-1:0] y,
  input logic clk 
 );
 timeunit 1ns/1ps;

   //fsdbfile
 initial begin
    $fsdbDumpfile("dump.fsdb");
    $fsdbDumpvars;
 end

 //sequence
 initial begin
    repeat(5) begin
        @(posedge clk);
        void'(std::randomize(a));
        void'(std::randomize(b));
        void'(std::randomize(sel));
        @(posedge clk) check_results;
    end
    @(posedge clk) $finish;
 end

 //scoreboard
 task check_results;
    $monitor("At %t: sel: %b, a: %b, b:%b",$time, sel, a, b);
    if(sel)
     $write("Expected: y = %b, Actual: y = %b", a, y);
     if(y == a) $display("Test Passed");
     else       $display("Test Failed");
    else
     $write("Expected: y = %b, Actual: y = %b", b, y);
     if(y == b) $display("Test Passed");
     else       $display("Test Failed");
 endtask

endmodule: test

module top;
    timeunit 1ns/1ps;
    parameter N = 4;
    logic sel;
    logic clk;
    logic [N-1:0] a, b;
    logic [N-1:0] y;

    mux2to1 #(.N(N)) dut (.sel(sel), .a(a), .b(b), .y(y));
    test #(.N(N)) test1(.sel(sel), .a(a), .b(b), .y(y), .clk(clk));

    //clock
    initial begin
        clk <= 0;
    end
    always #10 clk <= ~clk;

  

endmodule: top