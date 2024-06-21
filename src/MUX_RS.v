`timescale 1ns / 1ps

module MUX_RS#(parameter SIZE = 32)(

    input wire [0:0] equal,
    input wire [0:0] greater,
    input wire [0:0] less,
    input wire [SIZE-1:0] result,
    input wire [0:0] not_equal,
    input wire [2:0] select,
    output reg [SIZE-1:0] out

    );
    
    always @(*) begin
        case(select)
            3'b000 : out = {31'd0, equal};
            3'b001 : out = {31'd0, greater};
            3'b010 : out = {31'd0, less};
            3'b011 : out = result;
            3'b100 : out = {31'd0, not_equal};
            default: out = result;
        endcase
    end
endmodule

