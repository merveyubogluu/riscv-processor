module pipeline_EM(

    input wire clk,
    input wire rst,
    input wire MWE, 
    input wire RWE, 
    input wire [1:0] MDE, 
    input wire [1:0] wr_strbE,
    input wire AUIPCE, 
    input wire [2:0] rd_strbE,
    input wire [31:0] PCplus4E,
    input wire [4:0] A2E,
    input wire [31:0] FU_resultE,
    input wire [31:0] RD1E,
    input wire [31:0] PC_targetE,
    output reg MWM, 
    output reg RWM, 
    output reg [1:0] MDM, 
    output reg [1:0] wr_strbM,
    output reg AUIPCM, 
    output reg [2:0] rd_strbM,
    output reg [31:0] PCplus4M,
    output reg [4:0] A2M,
    output reg [31:0] FU_resultM,
    output reg [31:0] RD1M,
    output reg [31:0] PC_targetM
    );
    
    always @(posedge clk,negedge rst) begin
        if(!rst) begin
            MWM <= 0;
            RWM <= 0;
            MDM <= 0;
            wr_strbM <= 0;
            AUIPCM <= 0;
            rd_strbM <= 0;
            PCplus4M <= 0;
            A2M <= 0;
            FU_resultM <= 0;
            RD1M <= 0;
            PC_targetM <= 0;            
        end
        else begin
            MWM <= MWE;
            RWM <= RWE;
            MDM <= MDE;
            wr_strbM <= wr_strbE;
            AUIPCM <= AUIPCE;
            rd_strbM <= rd_strbE;
            PCplus4M <= PCplus4E;
            A2M <= A2E;
            FU_resultM <= FU_resultE;
            RD1M <= RD1E;
            PC_targetM <= PC_targetE;            
        end
    end
endmodule
