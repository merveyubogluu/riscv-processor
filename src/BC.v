module BC(
    input wire [0:0] Jump,
    input wire [0:0] Branch,
    input wire [0:0] result,
    output wire [0:0] PCS
    );
    
    assign PCS = (result && Branch) || Jump;
    
endmodule
