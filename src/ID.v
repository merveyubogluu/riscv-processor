module ID(

    input wire [31:0] instr,
    output reg [25:0] control_word
    );
        
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr [31:25];
    wire [6:0] opcode = instr [6:0];
    
    localparam LUI = 7'b0110111;
    localparam AUIPC = 7'b0010111;
    localparam JAL = 7'b1101111;
    localparam JALR = 7'b1100111;
    localparam BRANCH = 7'b1100011;
    localparam BEQ = 3'b000;
    localparam BNE = 3'b001;
    localparam BLT = 3'b100;
    localparam BGE = 3'b101;
    localparam BLTU = 3'b110;
    localparam BGEU = 3'b111;
    localparam LOAD = 7'b0000011;
    localparam LB = 3'b000;
    localparam LH = 3'b001;
    localparam LW = 3'b010;
    localparam LBU = 3'b100;
    localparam LHU = 3'b101;
    localparam STORE =  7'b0100011;
    localparam SB = 3'b000;
    localparam SH = 3'b001;
    localparam SW = 3'b010;
    localparam IMM = 7'b0010011;
    localparam ADDI = 3'b000;
    localparam SLTI = 3'b010;
    localparam SLTIU = 3'b011;
    localparam XORI = 3'b100;
    localparam ORI = 3'b110;
    localparam ANDI = 3'b111;
    localparam SLLI = 3'b001;
    localparam SRLI = 3'b101;
    localparam SRAI = 3'b101;
    localparam REG = 7'b0110011;
    localparam ADD = 3'b000;
    localparam SUB = 3'b000;
    localparam SLL = 3'b001;
    localparam SLT = 3'b010;
    localparam SLTU = 3'b011;
    localparam XOR = 3'b100;
    localparam SRL = 3'b101;
    localparam SRA = 3'b101;
    localparam OR = 3'b110;
    localparam AND = 3'b111;


    always @(*) begin
    
        case(opcode)
            LUI:    control_word = 26'b100110x_01001_xx_011_0_0_0_011_xxx;
            AUIPC:  control_word = 26'b100110x_01001_xx_011_0_0_1_011_xxx;
            JAL:    control_word = 26'bxxxxxxx_01101_xx_100_0_1_0_xxx_xxx;
            BRANCH: begin
                case(funct3)
                    BEQ: control_word = 26'bxxxxxxx_00xx0_xx_111_1_0_0_000_xxx;
                    BNE: control_word = 26'bxxxxxxx_00xx0_xx_111_1_0_0_100_xxx;
                    BLT: control_word = 26'bxxxxxxx_00xx0_xx_111_1_0_0_010_xxx;
                    BGE: control_word = 26'bxxxxxxx_00xx0_xx_111_1_0_0_001_xxx;
                endcase
            end
            LOAD: begin
                case(funct3)
                    LB: control_word = 26'b000xxx0_01011_xx_000_0_0_0_011_000;
                    LH: control_word = 26'b000xxx0_01011_xx_000_0_0_0_011_001;
                    LW: control_word = 26'b000xxx0_01011_xx_000_0_0_0_011_100;
                    LBU: control_word = 26'b000xxx0_01011_xx_000_0_0_0_011_010;
                    LHU: control_word = 26'b000xxx0_01011_xx_000_0_0_0_011_011;
                endcase
            end
            STORE: begin
                case(funct3)
                    SB: control_word = 26'b000xxx0_10001_10_001_0_0_0_011_xxx;
                    SH: control_word = 26'b000xxx0_10001_01_001_0_0_0_011_xxx;
                    SW: control_word = 26'b000xxx0_10001_00_001_0_0_0_011_xxx;
                endcase
            end
            IMM: begin
                case (funct3)
                    ADDI: control_word = 26'b000xxx0_01001_xx_000_0_0_0_011_xxx;
                    SLTI: control_word = 26'bxxxxxxx_01001_xx_000_0_0_0_010_xxx;
                    SLTIU: control_word = 26'bxxxxxxx_x1001_xx_101_0_0_0_010_xxx;
                    XORI: control_word = 26'b011xxxx_01001_xx_000_0_0_0_011_xxx;
                    ORI: control_word = 26'b010xxxx_01001_xx_000_0_0_0_011_xxx;
                    ANDI: control_word = 26'b001xxxx_01001_xx_000_0_0_0_011_xxx;
                    SLLI: control_word = 26'b100000x_01001_xx_000_0_0_0_011_xxx;
                    3'b101: begin // SRLI & SRAI
                        if (funct7 == 7'b0000000)
                            control_word = 26'b100001x_01001_xx_000_0_0_0_011_xxx;
                        else if (funct7 == 7'b0100000)
                            control_word = 26'b100010x_01001_xx_000_0_0_0_011_xxx;
                    end
                endcase
            end
            REG: begin
                case (funct3)
                    3'b000: begin // ADD & SUB
                        if (funct7 == 7'b0000000) // ADD
                            control_word = 26'b000xxx0_01000_xx_xxx_0_0_0_011_xxx;
                        else if (funct7 == 7'b0100000) // SUB
                            control_word = 26'b000xxx1_01000_xx_xxx_0_0_0_011_xxx;
                    end
                    SLL: control_word = 26'b100011x_01000_xx_xxx_0_0_0_011_xxx;
                    SLT: control_word = 26'bxxxxxxx_01000_xx_xxx_0_0_0_010_xxx;
//                    SLTU: control_word= 26'bxxxxxxx_x1001_xx1010010xxx;
                    XOR: control_word = 26'b011xxxx_01000_xx_xxx_0_0_0_011_xxx;
                    3'b101: begin // SRL & SRA
                        if (funct7 == 7'b0000000) // SRL
                            control_word = 26'b100100x_01000_xx_xxx_0_0_0_011_xxx;
                        else if (funct7 == 7'b0100000) // SRA
                            control_word = 26'b100101x_01000_xx_xxx_0_0_0_011_xxx;
                    end
                    OR: control_word = 26'b010xxxx_01000_xx_xxx_0_0_0_011_xxx;
                    AND: control_word = 26'b001xxxx_01000_xx_xxx_0_0_0_011_xxx;
                endcase            
            
            end
        endcase
    
    end    
endmodule
