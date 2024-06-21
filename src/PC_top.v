module PC_top#(parameter SIZE = 32)(

    input wire clk,
    input wire rst,
    input wire [SIZE-1:0] pc_plus4,
    input wire [SIZE-1:0] pc_target,
    input wire [0:0] Jump,
    input wire [0:0] Branch,
    input wire [0:0] result,
    input wire stallF,
    output wire PCSE,
    output wire [SIZE-1:0] pc

    );
    
    wire [SIZE-1:0] pc_next;
    wire PCS;
    
    assign PCSE = PCS;
    
    BC branch_controller (.Jump(Jump),
    .Branch(Branch),
    .result(result),
    .PCS(PCS));
    
    MUX_2_1 #(SIZE) mux_pc (.in_0(pc_plus4),
    .in_1(pc_target),
    .select(PCS),
    .out(pc_next));
    
    pc #(SIZE) program_counter (.clk(clk),
    .rst(rst),
    .en(stallF),
    .pc_next(pc_next),
    .pc(pc));
    
endmodule
