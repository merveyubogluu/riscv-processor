module Extender(
    input wire [2:0] ImmS,
    input wire [31:0] instr,
    output reg [31:0] ImmExt);
    
    always@(*) begin 
    
        case(ImmS)
            3'b000: ImmExt = {{20{instr[31]}},instr[31:20]};// I-TYPE
            3'b001: ImmExt = {{20{instr[31]}},instr[31:25],instr[11:7]};// S-TYPE
            3'b010: ImmExt = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};// B-TYPE
            3'b011: ImmExt = {instr[31:12],12'd0};// U-TYPE
            3'b100: ImmExt = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};// J-TYPE
            3'b101: ImmExt = {{20'd0},instr[31:20]};// I-TYPE UNSIGNED
            3'b110: ImmExt = {{20'd0},instr[31:25],instr[11:7]};// S-TYPE UNSIGNED
            3'b111: ImmExt = {{19'd0},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};// B-TYPE UNSIGNED        
        endcase
    end
endmodule 