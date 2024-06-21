`timescale 1ns / 1ps

module MUX_4_1#(parameter SIZE = 32)(

    input wire [SIZE-1:0] in_0,
    input wire [SIZE-1:0] in_1,
    input wire [SIZE-1:0] in_2,
    input wire [SIZE-1:0] in_3,
    input wire [1:0] select,
    output reg [SIZE-1:0] out

    );
    
    always @(*) begin
        case(select)
            2'b00 : out = in_0;
            2'b01 : out = in_1;
            2'b10 : out = in_2;
            2'b11 : out = in_3;
        endcase
    end
endmodule

