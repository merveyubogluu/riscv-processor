module Register_File#(parameter width = 32, parameter depth = 32, parameter adr_width = $clog2(depth))(

    input wire clk,
    input wire rst,
    input wire we0,
    input wire [adr_width-1:0] rd_addr0,
    input wire [adr_width-1:0] rd_addr1,
    input wire [adr_width-1:0] wr_addr0,
    input wire [width-1:0] wr_din0,
    output wire [width-1:0] rd_dout0,
    output wire [width-1:0] rd_dout1,
    output wire [width-1:0] C
    );
    
    reg [width-1:0] memory [depth-1:0];
    
    assign C = memory[1];
    
    integer i;
    
    localparam zero_addr = 0;
    
    always @(posedge clk,negedge rst) begin
    
        if(!rst) begin
            for(i=0 ; i < depth ; i = i + 1) 
                memory[i] <= 0;
        end
        else begin 
            if(we0)
                memory[wr_addr0] <= (wr_addr0 == zero_addr) ? 0 : wr_din0; 
            else
                memory[wr_addr0] <= memory[wr_addr0];
         end
    end
    
    assign rd_dout0 = memory[rd_addr0];
    assign rd_dout1 = memory[rd_addr1];
    
endmodule
