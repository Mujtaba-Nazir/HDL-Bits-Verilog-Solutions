module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter l = 0, r = 1;
    reg cr_state, next_state;

    always @(*) begin
        // State transition logic
        case(cr_state)
            l : next_state = bump_left ? r : l;
            r : next_state = bump_right ? l : r;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) cr_state <= l;
        else cr_state <= next_state;
        
    end

    // Output logic
    assign walk_left = (cr_state == l);
    assign walk_right = (cr_state == r);

endmodule
