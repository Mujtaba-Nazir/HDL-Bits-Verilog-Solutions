module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    parameter S0=0,S1=1,S11=2,S110=3, S1101=4, SH0=5, SH1=6, SH2=7, count=8, hold=9;
    reg[3:0] cr_state, next_state;
    
    always@ (*) begin
        case(cr_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S11: S0;
            S11: next_state = data  ? S11:S110;
            S110: next_state = data? S1101 : S0;
            S1101: next_state = SH0;
            SH0: next_state = SH1;
            SH1: next_state = SH2;
            SH2: next_state = count;
            count: next_state = done_counting ? hold:count;
            hold: next_state = ack ? S0:hold;
        endcase
    end

    always@(posedge clk) begin
        if (reset)
            cr_state <= S0;
        else
            cr_state <= next_state;
    end
    
    assign shift_ena = (cr_state == S1101) || (cr_state == SH0) || (cr_state==SH1)||(cr_state==SH2);
    assign counting = (cr_state==count);
    assign done = (cr_state==hold);

endmodule
