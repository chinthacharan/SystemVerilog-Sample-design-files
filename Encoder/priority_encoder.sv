module priority_encoder(
    input logic [7:0] D,
    output logic [2:0] Q
);
    timeunit 1ns/1ps;

    always_comb begin
        if(D[7]) Q = 3'b111;
        else if(D[6]) Q = 3'b110;
        else if(D[5]) Q = 3'b101;
        else if(D[4]) Q = 3'b100;
        else if(D[3]) Q = 3'b011;
        else if(D[2]) Q = 3'b010;
        else if(D[1]) Q = 3'b001;
        else Q = 3'b000;
    end
endmodule