module ALU#(parameter SIZE = 32)(

    input wire [SIZE-1:0] operand1,
    input wire [SIZE-1:0] operand2,
    input wire [6:0] ALUop,
    output wire equal_flag,
    output wire greater_flag,
    output wire less_flag,
    output wire [SIZE-1:0] result

    );
    
    wire [SIZE-1:0] add_sub_r;
    wire [SIZE-1:0] and_r;
    wire [SIZE-1:0] or_r;
    wire [SIZE-1:0] xor_r;
    wire [SIZE-1:0] shift_r;
    
    ADD_SUB add_sub1 (.x(operand1),
    .y(operand2),
    .ci(ALUop[0]),
    .s(add_sub_r));
    
    OR or1 (.A(operand1),
    .B(operand2),
    .C(or_r));
    
    XOR xor1 (.A(operand1),
    .B(operand2),
    .C(xor_r));
    
    AND and1 (.A(operand1),
    .B(operand2),
    .C(and_r));
    
    shifter shift1 (.A(operand1),
    .B(operand2),
    .MOD(ALUop[3:1]),
    .C(shift_r));
    
    comparator comp1 (.A(operand1),
    .B(operand2),
    .equal_flag(equal_flag),
    .greater_flag(greater_flag),
    .less_flag(less_flag));
    
    MUX mux_alu(.add_sub_r(add_sub_r), 
    .and_r(and_r),
    .or_r(or_r), 
    .xor_r(xor_r), 
    .shift_r(shift_r), 
    .select(ALUop[6:4]), 
    .C(result));
   
endmodule
