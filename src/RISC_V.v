module RISC_V(

    input wire clk,
    input wire rst,
    output wire [31:0] C
    );
    
    wire [31:0] instr;
    wire [25:0] control_word;
    wire [31:0] pc_plus4;
    wire [31:0] pc_target;
    wire [0:0] Jump;
    wire [0:0] Branch;
    wire [0:0] FU_result_0;
    wire [31:0] pc;
    wire PCSE;
    wire stallF;
    
    Controller CU (
    .clk(clk),
    .rst(rst),
    .pc_plus4(pc_plus4),
    .pc_target(pc_target),
    .Jump(Jump),
    .Branch(Branch),
    .FU_result_0(FU_result_0),
    .stallF(stallF),
    .instr(instr),
    .control_word(control_word),
    .PCSE(PCSE),
    .pc(pc)
    );
    
    Datapath DP (
    .clk(clk),
    .rst(rst),
    .PCSE(PCSE),
    .control_word(control_word),
    .pc(pc),
    .instr(instr),
    .pc_plus4(pc_plus4),
    .pc_target(pc_target),
    .Jump(Jump),
    .Branch(Branch),
    .FU_result_0(FU_result_0),
    .stallF(stallF),
    .C(C) 
    );

    
endmodule
