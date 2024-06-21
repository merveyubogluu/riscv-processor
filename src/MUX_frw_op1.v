module MUX_frw_op1(

    input wire [31:0] RD0E,
    input wire [31:0] ResultW,
    input wire [31:0] FU_resultM,
    input wire [1:0] forward_op1E,
    output reg [31:0] operand1

    );
    
    always @(*) begin
        case(forward_op1E)
            2'b00: operand1 = RD0E;
            2'b01: operand1 = ResultW;
            2'b10: operand1 = FU_resultM;
            default: operand1 = RD0E;
        endcase
    end
endmodule
