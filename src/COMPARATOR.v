module comparator #(parameter SIZE = 32)(

    input wire [SIZE-1:0] A,
    input wire [SIZE-1:0] B,
    output wire equal_flag,
    output wire greater_flag,
    output wire less_flag
    );
    
    assign equal_flag = (A == B) ? 1'b1 : 1'b0;
    assign greater_flag = (A > B) ? 1'b1 : 1'b0;
    assign less_flag = (A < B) ? 1'b1 : 1'b0;
    
endmodule