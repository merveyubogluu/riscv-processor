module hazard_unit(

    input wire [4:0] A0D,
    input wire [4:0] A1D,
    input wire [4:0] A0E,
    input wire [4:0] A1E,
    input wire [4:0] A2E,
    input wire [4:0] A2M,
    input wire [4:0] A2W,
    input wire MDE0,
    input wire PCSE,
    input wire RWM,
    input wire RWW,
    output reg [1:0] forward_op1E,
    output reg [1:0] forward_op2E,
    output wire stallF,
    output wire stallD,
    output wire flushD,
    output wire flushE
    
    );
    
    always @(*) begin
        if(((A0E == A2M) && RWM) && (A0E != 0)) begin
            forward_op1E = 2'b10;
        end
        else if(((A0E == A2W) && RWW) && (A0E != 0)) begin
            forward_op1E = 2'b01;
        end 
        else begin
            forward_op1E = 2'b00;
        end
    end
    
    always @(*) begin
        if(((A1E == A2M) && RWM) && (A1E != 0)) begin
            forward_op2E = 2'b10;
        end
        else if(((A1E == A2W) && RWW) && (A1E != 0)) begin
            forward_op2E = 2'b01;
        end 
        else begin
            forward_op2E = 2'b00;
        end
    end
    
    assign stallF = (((A0D == A2E) || (A1D == A2E)) && MDE0);
    assign stallD = (((A0D == A2E) || (A1D == A2E)) && MDE0);
    assign flushE = (((A0D == A2E) || (A1D == A2E)) && MDE0) || PCSE ;
    assign flushD = PCSE;
    
endmodule
