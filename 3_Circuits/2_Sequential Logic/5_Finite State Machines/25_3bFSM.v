module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] cr_state, next_state;

    always @(*) begin
        case (cr_state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            cr_state <= S0;
        end
        else begin
            cr_state <= next_state;
        end
    end

    assign z = (cr_state == S3 || cr_state == S4);


endmodule
