module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg[2:0] cr_state,next_state;
    parameter S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4;
    
    always@(*) begin
        case(y)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3; 
        endcase
    end
    
    always@(posedge clk) begin
       cr_state <= next_state; 
    end

    assign z = (y == S3) || (y == S4);
    assign Y0 = next_state[0];
endmodule


