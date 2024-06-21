module shifter #(parameter SIZE = 32)(

    input wire [SIZE-1:0] A,
    input wire [SIZE-1:0] B,
    input wire [2:0] MOD,
    output reg [SIZE-1:0] C
    );
    
    localparam SLLI = 3'b000;
    localparam SRLI = 3'b001;
    localparam SRAI = 3'b010;
    localparam SLL = 3'b011;
    localparam SRL = 3'b100;
    localparam SRA = 3'b101;
    localparam LUI = 3'b110;
    
    
    always @(*) begin
    case(MOD)
        SLLI : C = A << B;
        SRLI : C = A >> B;
        SRAI : C = A >>> B;
        SLL : C = A << B;
        SRL : C = A >> B;
        SRA : C = A >>> B;
        LUI : C = B << 12;
    endcase
    end
endmodule
    