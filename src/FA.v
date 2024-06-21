module FA(
    
    input wire A,
    input wire B,
    input wire Cin,
    output wire SUM,
    output wire Cout
   
    );
    
    assign SUM = A ^ B ^ Cin;
    assign Cout = (A&B)|(Cin&(A^B));
    
endmodule
