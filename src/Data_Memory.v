module Data_Memory#(parameter width = 32, parameter depth = 256, parameter adr_width = $clog2(depth))(

    input wire clk,
    input wire rst,
    input wire we0,
    input wire [1:0] wr_strb,
    input wire [2:0] rd_strb,
    input wire [31:0] rd_addr0,
    input wire [31:0] wr_addr0,
    input wire [width-1:0] wr_din0,
    output reg [width-1:0] rd_dout0
    

    );
    
    reg [width-1:0] memory [depth-1:0];
    
    initial $readmemh("C:/Users/fatih/Desktop/VLSI-2/project_6pipelined_son/project_6pipelined.srcs/sim_1/imports/sim_1/imports/project 5/datamem.txt", memory);
    
    localparam SW = 2'b00;
    localparam SH = 2'b01;
    localparam SB = 2'b10;
    
    integer i;
    
    always @(posedge clk,negedge rst) begin
    
//        if(!rst) begin
//            for(i=0 ; i < depth ; i = i + 1) 
//                memory[i] <= 0;
//        end
//        else begin 
            if(we0) begin 
                case(wr_strb)
                    SW: memory[wr_addr0>>2] <= wr_din0; 
                    SH: memory[wr_addr0>>2][15:0] <= wr_din0[15:0];
                    SB: memory[wr_addr0>>2][7:0] <= wr_din0[7:0];
                    default:memory[wr_addr0>>2] <= wr_din0;
                endcase
            end
            else
                memory[wr_addr0>>2] <= memory[wr_addr0>>2];
//         end
    end
        
    always @(*) begin
        case (rd_strb)
            3'b000: rd_dout0 = {{24{memory[rd_addr0>>2][31]}}, memory[rd_addr0>>2][7:0]};
            3'b001: rd_dout0 = {{16{memory[rd_addr0>>2][31]}}, memory[rd_addr0>>2][15:0]};
            3'b010: rd_dout0 = {{24'd0}, memory[rd_addr0>>2][7:0]};
            3'b011: rd_dout0 = {{16'd0}, memory[rd_addr0>>2][15:0]};
            3'b100: rd_dout0 = memory[rd_addr0>>2];
            default: rd_dout0 = memory[rd_addr0>>2];
        endcase
    end
    
endmodule

