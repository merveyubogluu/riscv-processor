module MUX_2_1#(parameter SIZE = 32)(

    input wire [SIZE-1:0] in_0,
    input wire [SIZE-1:0] in_1,
    input wire select,
    output reg [SIZE-1:0] out

    );
    
    always @(*) begin
        case(select)
            1'b0 : out = in_0;
            1'b1 : out = in_1;
        endcase
    end
endmodule
