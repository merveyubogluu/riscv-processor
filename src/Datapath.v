module Datapath#(parameter SIZE = 32)(

    input wire clk,
    input wire rst,
    input wire PCSE,
    input wire [25:0] control_word,
    input wire [31:0] pc,
    output wire [31:0] instr,
    output wire [31:0] pc_plus4,
    output wire [31:0] pc_target,
    output wire [0:0] Jump,
    output wire [0:0] Branch,
    output wire [0:0] FU_result_0,
    output wire stallF,
    output wire [31:0] C

    );
    
    wire [6:0] ALUopD = control_word[25:19];
    wire MWD = control_word[18];
    wire RWD = control_word[17];
    wire [1:0] MDD = control_word [16:15];
    wire MBD = control_word[14];
    wire [1:0] wr_strbD = control_word[13:12];
    wire [2:0] ImmSD = control_word[11:9];
    wire BranchD = control_word[8];
    wire JumpD = control_word[7];
    wire AUIPCD = control_word[6];
    wire [2:0] RSD = control_word[5:3];
    wire [2:0] rd_strbD = control_word[2:0];
    
    
    wire [6:0] ALUopE;
    wire MWE;
    wire RWE;
    wire [1:0] MDE;
    wire MBE;
    wire [1:0] wr_strbE;
    wire BranchE;
    wire JumpE;
    wire AUIPCE;
    wire [2:0] RSE;
    wire [2:0] rd_strbE; 
    
    wire [6:0] ALUopM;
    wire MWM;
    wire RWM;
    wire [1:0] MDM;
    wire MBM;
    wire [1:0] wr_strbM;
    wire AUIPCM;
    wire [2:0] rd_strbM;
    
    wire [1:0] MDW;
    wire RWW;
    wire AUIPCW;
       
    wire [31:0] instrF;
    wire [31:0] instrD;
    
    wire [4:0] A0D = instrD[19:15];
    wire [4:0] A1D = instrD[24:20];
    wire [4:0] A2D = instrD[11:7];
    wire [4:0] A0E;
    wire [4:0] A1E;
    wire [4:0] A2E;
    wire [4:0] A2M;
    wire [4:0] A2W;

    
    wire [31:0] WD2;
    
    wire [31:0] RD0D;
    wire [31:0] RD1D;
    wire [31:0] RD0E;
    wire [31:0] RD1E;
    wire [31:0] RD1M;
    
    wire [31:0] RD1_fu;
    wire [31:0] FU_resultE;
    wire [31:0] FU_resultM;
    wire [31:0] FU_resultW;
    wire [31:0] ALU_result;
    
    wire [31:0] Datamem_outM;
    wire [31:0] Datamem_outW;
    
    wire [31:0] result;
    
    
    wire [31:0] ImmExtD;
    wire [31:0] ImmExtE;
    
    wire [31:0] PCF;
    wire [31:0] PCD;
    wire [31:0] PCE;

    wire [31:0] PC_plus4F;
    wire [31:0] PC_plus4D;
    wire [31:0] PC_plus4E;
    wire [31:0] PC_plus4M;
    wire [31:0] PC_plus4W;

    
    wire [31:0] PC_target;
    wire [31:0] PC_targetE;
    wire [31:0] PC_targetM;
    wire [31:0] PC_targetW;
    wire [31:0] PC_next; 
    
    wire equal_flag;
    wire greater_flag;
    wire less_flag;
    wire not_equal_flag;
    
    wire PCS;
    
    wire [31:0] operand1;
    wire [31:0] operand2E;
    wire [31:0] operand2M;
    
    wire [1:0] forward_op1E;
    wire [1:0] forward_op2E;
    
    wire stallD;
    wire flushD;
    wire flushE;
    
    assign not_equal_flag = ~equal_flag;
    assign instr = instrD;
    
    Memory IM (.rd_addr0(PCF),
    .rd_dout0(instrF));
    
    pipeline_FD FD (.clk(clk),
    .rst(rst),
    .clr(flushD),
    .en(stallD),
    .instrF(instrF),
    .PCF(PCF),
    .PCplus4F(PC_plus4F),
    .instrD(instrD),
    .PCD(PCD),
    .PCplus4D(PC_plus4D));     
      
    Register_File reg_file (.clk(clk),
    .rst(rst),
    .we0(RWW),
    .rd_addr0(A0D),
    .rd_addr1(A1D),
    .wr_addr0(A2W),
    .wr_din0(WD2),
    .rd_dout0(RD0D),
    .rd_dout1(RD1D),
    .C(C));
    
    
    
    pipeline_DE DE (.clk(clk),
    .rst(rst),
    .clr(flushE),
    .ALUopD(ALUopD),
    .MWD(MWD), 
    .RWD(RWD), 
    .MDD(MDD), 
    .MBD(MBD), 
    .wr_strbD(wr_strbD),
    .BranchD(BranchD), 
    .JumpD(JumpD),
    .AUIPCD(AUIPCD), 
    .RSD(RSD), 
    .rd_strbD(rd_strbD),
    .ImmExtD(ImmExtD),
    .PCD(PCD),
    .PCplus4D(PC_plus4D),
    .RD0D(RD0D),
    .RD1D(RD1D),
    .A0D(A0D),
    .A1D(A1D),
    .A2D(A2D),
    .ALUopE(ALUopE),
    .MWE(MWE), 
    .RWE(RWE), 
    .MDE(MDE), 
    .MBE(MBE), 
    .wr_strbE(wr_strbE),
    .BranchE(BranchE), 
    .JumpE(JumpE),
    .AUIPCE(AUIPCE), 
    .RSE(RSE), 
    .rd_strbE(rd_strbE),
    .ImmExtE(ImmExtE),
    .PCE(PCE),
    .PCplus4E(PC_plus4E),
    .RD0E(RD0E),
    .RD1E(RD1E),
    .A0E(A0E),
    .A1E(A1E),
    .A2E(A2E));
    
    MUX_frw_op1 frw_mux1(.RD0E(RD0E),
    .ResultW(result),
    .FU_resultM(FU_resultM),
    .forward_op1E(forward_op1E),
    .operand1(operand1));
    
    MUX_frw_op2 frw_mux2(.RD1E(RD1E),
    .ResultW(result),
    .FU_resultM(FU_resultM),
    .forward_op2E(forward_op2E),
    .operand2(operand2E));
    
    ALU fu(.operand1(operand1),
    .operand2(RD1_fu),
    .ALUop(ALUopE),
    .equal_flag(equal_flag),
    .greater_flag(greater_flag),
    .less_flag(less_flag),
    .result(ALU_result));
    
    pipeline_EM EM (.clk(clk),
    .rst(rst),
    .MWE(MWE), 
    .RWE(RWE), 
    .MDE(MDE), 
    .wr_strbE(wr_strbE),
    .AUIPCE(AUIPCE), 
    .rd_strbE(rd_strbE),
    .PCplus4E(PC_plus4E),
    .A2E(A2E),
    .FU_resultE(FU_resultE),
    .RD1E(operand2E),
    .PC_targetE(PC_targetE),
    .MWM(MWM), 
    .RWM(RWM), 
    .MDM(MDM), 
    .wr_strbM(wr_strbM),
    .AUIPCM(AUIPCM), 
    .rd_strbM(rd_strbM),
    .PCplus4M(PC_plus4M),
    .A2M(A2M),
    .FU_resultM(FU_resultM),
    .RD1M(operand2M),
    .PC_targetM(PC_targetM));
    
    MUX_RS MUX_RS(.equal(equal_flag),
    .greater(greater_flag),
    .less(less_flag),
    .result(ALU_result),
    .not_equal(not_equal_flag),
    .select(RSE),
    .out(FU_resultE));
    
    MUX_2_1 MUX_MB(.in_0(operand2E),
    .in_1(ImmExtE),
    .select(MBE),
    .out(RD1_fu));
    
    Extender extend(.ImmS(ImmSD),
    .instr(instrD),
    .ImmExt(ImmExtD));
    
    Data_Memory datamemory(.clk(clk),
    .rst(rst),
    .we0(MWM),
    .wr_strb(wr_strbM),
    .rd_strb(rd_strbM),
    .rd_addr0(FU_resultM),
    .wr_addr0(FU_resultM),
    .wr_din0(operand2M),
    .rd_dout0(Datamem_outM));
    
    pipeline_MW MW1 (.clk(clk),
    .rst(rst),
    .RWM(RWM), 
    .MDM(MDM), 
    .AUIPCM(AUIPCM), 
    .PCplus4M(PC_plus4M),
    .A2M(A2M),
    .FU_resultM(FU_resultM),
    .Datamem_outM(Datamem_outM),
    .PC_targetM(PC_targetM),
    .RWW(RWW), 
    .MDW(MDW), 
    .AUIPCW(AUIPCW), 
    .PCplus4W(PC_plus4W),
    .A2W(A2W),
    .FU_resultW(FU_resultW),
    .Datamem_outW(Datamem_outW),
    .PC_targetW(PC_targetW));
    
    MUX_4_1 MUX_MD (.in_0(FU_resultW),
    .in_1(Datamem_outW),
    .in_2(PC_plus4W),
    .select(MDW),
    .out(result));
    
    MUX_2_1 MUX_AUIPC(.in_0(result),
    .in_1(PC_targetW),
    .select(AUIPCW),
    .out(WD2));
    
    Adder target_adder (.A(PCE),
    .B(ImmExtE),
    .C(PC_target));
    
    PC_4adder pc_adder (.A(PCF),
    .C(PC_plus4F));
    
    hazard_unit HU (.A0D(A0D),
    .A1D(A1D),
    .A0E(A0E),
    .A1E(A1E),
    .A2E(A2E),
    .A2M(A2M),
    .A2W(A2W),
    .MDE0(MDE[0]),
    .PCSE(PCSE),
    .RWM(RWM),
    .RWW(RWW),
    .forward_op1E(forward_op1E),
    .forward_op2E(forward_op2E),
    .stallF(stallF),
    .stallD(stallD),
    .flushD(flushD),
    .flushE(flushE));
    
    assign pc_plus4 = PC_plus4F;
    assign pc_target = PC_target;
    assign PCF = pc;
    assign Jump = JumpE;
    assign Branch = BranchE;
    assign FU_result_0 = FU_resultE[0];
    assign PC_targetE = PC_target;

    
endmodule
