module Memory#(parameter width = 32, parameter depth = 256, parameter adr_width = $clog2(depth))(

    input wire [31:0] rd_addr0,
    output wire [31:0] rd_dout0
    );
    
    reg [width-1:0] memory [depth-1:0];
    
    integer i;
    
    assign rd_dout0 = memory[rd_addr0>>2];
    
    initial $readmemh("C:/Users/fatih/Desktop/VLSI-2/project_6pipelined_son/project_6pipelined.srcs/sim_1/imports/sim_1/imports/Desktop/imem.txt", memory); 
    
endmodule
