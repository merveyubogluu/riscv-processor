module MUX_frw_op2(

    input wire [31:0] RD1E,
    input wire [31:0] ResultW,
    input wire [31:0] FU_resultM,
    input wire [1:0] forward_op2E,
    output reg [31:0] operand2

    );
    
    always @(*) begin
        case(forward_op2E)
            2'b00: operand2 = RD1E;
            2'b01: operand2 = ResultW;
            2'b10: operand2 = FU_resultM;
            default: operand2 = RD1E;
        endcase
    end
endmodule