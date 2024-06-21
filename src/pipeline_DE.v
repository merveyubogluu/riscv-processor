module pipeline_DE(

    input wire clk,
    input wire rst,
    input wire clr,
    input wire [6:0] ALUopD,
    input wire MWD, 
    input wire RWD, 
    input wire [1:0] MDD, 
    input wire MBD, 
    input wire [1:0] wr_strbD,
    input wire BranchD, 
    input wire JumpD,
    input wire AUIPCD, 
    input wire [2:0] RSD, 
    input wire [2:0] rd_strbD,
    input wire [31:0] ImmExtD,
    input wire [31:0] PCD,
    input wire [31:0] PCplus4D,
    input wire [31:0] RD0D,
    input wire [31:0] RD1D,
    input wire [4:0] A0D,
    input wire [4:0] A1D,
    input wire [4:0] A2D,
    output reg [6:0] ALUopE,
    output reg MWE, 
    output reg RWE, 
    output reg [1:0] MDE, 
    output reg MBE, 
    output reg [1:0] wr_strbE,
    output reg BranchE,
    output reg JumpE, 
    output reg AUIPCE, 
    output reg [2:0] RSE, 
    output reg [2:0] rd_strbE,
    output reg [31:0] ImmExtE,
    output reg [31:0] PCE,
    output reg [31:0] PCplus4E,
    output reg [31:0] RD0E,
    output reg [31:0] RD1E,
    output reg [4:0] A0E,
    output reg [4:0] A1E,
    output reg [4:0] A2E

    );
    
    always @(posedge clk,negedge rst) begin
        if(!rst || clr ) begin
            ALUopE <= 0;
            MWE <= 0;
            RWE <= 0;
            MDE <= 0;
            MBE <= 0;
            wr_strbE <= 0;
            BranchE <= 0;
            JumpE <= 0;
            AUIPCE <= 0;
            RSE <= 0;
            rd_strbE <= 0;
            ImmExtE <= 0;
            PCE <= 0;
            PCplus4E <= 0;
            RD0E <= 0;
            RD1E <= 0;
            A0E <= 0;
            A1E <= 0;
            A2E <= 0;
            
        end
        else begin
            ALUopE <= ALUopD;
            MWE <= MWD;
            RWE <= RWD;
            MDE <= MDD;
            MBE <= MBD;
            wr_strbE <= wr_strbD;
            BranchE <= BranchD;
            JumpE <= JumpD;
            AUIPCE <= AUIPCD;
            RSE <= RSD;
            rd_strbE <= rd_strbD;
            ImmExtE <= ImmExtD;
            PCE <= PCD;
            PCplus4E <= PCplus4D;
            RD0E <= RD0D;
            RD1E <= RD1D;
            A0E <= A0D;
            A1E <= A1D;
            A2E <= A2D;
        end
    end
endmodule
