module pipeline_MW(

    input wire clk,
    input wire rst,
    input wire RWM, 
    input wire [1:0] MDM, 
    input wire AUIPCM, 
    input wire [31:0] PCplus4M,
    input wire [4:0] A2M,
    input wire [31:0] FU_resultM,
    input wire [31:0] Datamem_outM,
    input wire [31:0] PC_targetM,
    output reg RWW, 
    output reg [1:0] MDW, 
    output reg AUIPCW, 
    output reg [31:0] PCplus4W,
    output reg [4:0] A2W,
    output reg [31:0] FU_resultW,
    output reg [31:0] Datamem_outW,
    output reg [31:0] PC_targetW
    );
    
    always @(posedge clk,negedge rst) begin
        if(!rst) begin
            RWW <= 0;
            MDW <= 2'd0;
            AUIPCW <= 0;
            PCplus4W <= 0;
            A2W <= 0;
            FU_resultW <= 0;
            Datamem_outW <= 0;
            PC_targetW <= 0;
            
        end
        else begin
            RWW <= RWM;
            MDW <= MDM;
            AUIPCW <= AUIPCM;
            PCplus4W <= PCplus4M;
            A2W <= A2M;
            FU_resultW <= FU_resultM;
            Datamem_outW <= Datamem_outM;
            PC_targetW <= PC_targetM;
        end
    end
endmodule
