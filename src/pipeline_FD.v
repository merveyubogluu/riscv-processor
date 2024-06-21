module pipeline_FD(

    input wire clk,
    input wire rst,
    input wire clr,
    input wire en,
    input wire [31:0] instrF,
    input wire [31:0] PCF,
    input wire [31:0] PCplus4F,
    output reg [31:0] instrD,
    output reg [31:0] PCD,
    output reg [31:0] PCplus4D
    );
    
    always @(posedge clk,negedge rst) begin
        if(!rst || clr) begin
            instrD <= 0;
            PCD <= 0;
            PCplus4D <= 0;
        end
        else begin
            if((en == 0)) begin
                instrD <= instrF;
                PCD <= PCF;
                PCplus4D <= PCplus4F;
            end
            else begin
                instrD <= instrD;
                PCD <= PCD;
                PCplus4D <= PCplus4D;
            end
        end
    end
endmodule

    
