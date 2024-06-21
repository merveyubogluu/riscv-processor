module pc#(parameter SIZE = 32)(

    input wire clk,
    input wire rst,
    input wire en,
    input wire [SIZE-1:0] pc_next,
    output reg [SIZE-1:0] pc

    );
    
    always @(posedge clk,negedge rst) begin 
        if(!rst) begin
            pc <= 0;
        end
        else  begin
            if(!en) begin
                pc <= pc_next;
            end
            else begin
                pc <= pc;
            end
        end
    end
endmodule
