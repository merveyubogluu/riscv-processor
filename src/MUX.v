module MUX#(parameter SIZE = 32)(

    input wire [SIZE-1:0] add_sub_r,
    input wire [SIZE-1:0] and_r,
    input wire [SIZE-1:0] or_r,
    input wire [SIZE-1:0] xor_r,
    input wire [SIZE-1:0] shift_r,
    input wire [2:0] select,
    output reg [SIZE-1:0] C

    );
    
    localparam ADD_SUB = 3'b000;
    localparam AND = 3'b001;
    localparam OR = 3'b010;
    localparam XOR = 3'b011;
    localparam SHIFT = 3'b100;
    
    always @(*) begin
        case(select)
            ADD_SUB: C = add_sub_r;
            AND: C = and_r;
            OR: C = or_r;
            XOR: C = xor_r;
            SHIFT: C = shift_r;
            default: C = 32'dx;
        endcase
    end
endmodule
