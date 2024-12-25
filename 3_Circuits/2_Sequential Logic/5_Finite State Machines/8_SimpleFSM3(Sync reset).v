module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    reg [2:0] cr_state, next_state;
    parameter A = 0, B = 1, C = 2, D = 3;
    
    // State transition logic
    always @(*) begin
        case(cr_state)
            A : next_state = in ? B : A;
            B : next_state = in ? B : C;
            C : next_state = in ? D : A;
            D : next_state = in ? B : C;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
        if(reset) cr_state <= A;
        else cr_state <= next_state;
    end

    // Output logic
    assign out = (cr_state == D);

endmodule
