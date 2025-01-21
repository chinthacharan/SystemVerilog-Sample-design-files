module test(
    input logic [2:0] Q,
    output logic [7:0] D,
    input logic clk
);
 timeunit 1ns/1ps;

 //fsdb
 initial begin
    $fsdbDumpfile("dump.fsdb");
    $fsdbDumpvars;
 end

 //sequence
 initial begin
    repeat(5) begin
        @(posedge clk) ;
        void'(std::randomize(D));
        @(posedge clk) check_results;
    end
    @(posedge clk) $finish;
 end

 //scoreboard
 task check_results;
    $monitor("At %t D : %d, Q : %d",$time, D, Q);
    if(Q == encoded(D)) $display("Test Passed");
    else $display("Test Failed");
 endtask
 
 //encoded function
 function void encoded([7:0] d);
    encoded <= '0;
    for(int i = 7; i >= 0; i++)
        if(d[i]) begin
            encoded = i;
            break;
        end
 endfunction

endmodule

module top;
    timeunit 1ns/1ps;
    logic clk;
    logic [7:0] D;
    logic [2:0] Q;

    test test1 (.*);
    priority_encoder dut (.*);

    //clock gen
    initial begin
        clk <= 0;
    end
    always #10 clk <= ~clk;

endmodule