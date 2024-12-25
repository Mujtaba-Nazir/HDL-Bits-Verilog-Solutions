module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    parameter S0=0,S1=1,S11=2,S110=3,S1101=4;
    reg[2:0] cr_state,next_state;
    
    always@(*) begin
        case(cr_state)
            S0 : next_state = data ? S1:S0;
            S1 : next_state = data ? S11:S0;
            S11 : next_state = data ? S11:S110;
            S110 : next_state = data ? S1101:S0;
            S1101 : next_state = reset ? S0:S1101;
        endcase
    end
    
    always@(posedge clk) begin
        if (reset)
            cr_state <= S0;
        else
        cr_state <= next_state;
    end
            
    assign start_shifting = (cr_state == S1101);

endmodule
