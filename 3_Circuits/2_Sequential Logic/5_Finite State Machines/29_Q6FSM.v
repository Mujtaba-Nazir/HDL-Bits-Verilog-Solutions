module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5;
    reg[3:0] cr_state,next_state;
    
    always@(*) begin
        case(cr_state)
            S0: next_state = w ? S0:S1;
            S1: next_state = w ? S3:S2;
            S2: next_state = w ? S3:S4;
            S3: next_state = w ? S0:S5;
            S4: next_state = w ? S3:S4;
            S5: next_state = w ? S3:S2;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset)
            cr_state <= S0;
        else
            cr_state <= next_state;
    end
    
    assign z = (cr_state==S4) || (cr_state == S5); 
endmodule
