module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    wire r1,r2,r3,g1,g2,g3;
    assign {r3,r2,r1} = r;
    assign g = {g3,g2,g1};
    
    parameter S0=0,S1=1,S2=2,S3=3;
    reg[1:0] cr_state, next_state; 
    
    always@(*) begin
        case(cr_state) 
            S0: next_state = r1 ? S1 : (r2 ? S2 : (r3 ? S3 : S0));
            S1: next_state = r1 ? S1 : S0;
            S2: next_state = r2 ? S2 : S0;
            S3: next_state = r3 ? S3 : S0;
            default next_state = S0;
        endcase
    end
    
    always@(posedge clk) begin
        if (!resetn)
            cr_state <= S0;
        else
            cr_state <= next_state;
    end
    
    assign g1 = (cr_state == S1);
    assign g2 = (cr_state == S2);
    assign g3 = (cr_state == S3);

endmodule
