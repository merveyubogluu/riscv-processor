module Controller #(parameter SIZE = 32)(
    input wire clk,
    input wire rst,
    input wire [SIZE-1:0] pc_plus4,
    input wire [SIZE-1:0] pc_target,
    input wire [0:0] Jump,
    input wire [0:0] Branch,
    input wire [0:0] FU_result_0,
    input wire stallF,
    input wire [31:0] instr,
    output wire [25:0] control_word,
    output wire PCSE,
    output wire [SIZE-1:0] pc
    );
    

    ID instruction_decoder(
    .instr(instr),
    .control_word(control_word)
    );
    
    PC_top #(SIZE) pc_top1(
    .clk(clk),
    .rst(rst),
    .pc_plus4(pc_plus4),
    .pc_target(pc_target),
    .Jump(Jump),
    .Branch(Branch),
    .result(FU_result_0),
    .stallF(stallF),
    .PCSE(PCSE),
    .pc(pc)
    );
    
endmodule
