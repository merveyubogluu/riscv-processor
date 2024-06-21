module ADD_SUB #(parameter SIZE = 32)(

input wire [SIZE-1:0] x,y,
input wire ci,
output wire [SIZE-1:0] s
);


wire [SIZE:0] w;
wire [SIZE:0] y_xor;

genvar i;

assign w[0]= ci;
generate 
    for (i=0; i<SIZE ; i = i + 1) begin
        FA fa_1 (.A(x[i]),.B(y_xor[i]),.Cin(w[i]),.SUM(s[i]),.Cout(w[i+1]));
        xor exor_1(y_xor[i], y[i],ci);
    end
endgenerate
endmodule

