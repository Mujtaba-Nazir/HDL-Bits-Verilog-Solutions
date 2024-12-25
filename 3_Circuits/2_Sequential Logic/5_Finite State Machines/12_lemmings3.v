module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter [2:0] WL = 3'b000,
                     WR = 3'b001,
                     FL = 3'b010,
                     FR = 3'b011,
                     DL  = 3'b100,
                     DR  = 3'b101;

    reg [2:0] cr_state, next_state;

    always @(posedge clk or posedge areset) begin
        if(areset) cr_state <= WL;
        else cr_state <= next_state;
    end

    always @(*) begin
        case(cr_state)
            WL : begin
                if(ground==0) next_state = FL;
                else begin
                    if(dig) next_state = DL;
                    else begin
                        if(bump_left) next_state = WR;
                        else next_state = WL;
                    end
                end
            end
            WR : begin
                if(ground==0) next_state = FR;
                else begin
                    if(dig) next_state = DR;
                    else begin
                        if(bump_right) next_state = WL;
                        else next_state = WR;
                    end
                end
            end
            FL : next_state = ground ? WL : FL;
            FR : next_state = ground ? WR : FR;
            DL : next_state = ground ? DL : FL;
            DR : next_state = ground ? DR : FR;
        endcase
    end

    assign walk_left = (cr_state == WL);
    assign walk_right = (cr_state == WR);
    assign aaah = ((cr_state == FL) || (cr_state == FR));
    assign digging = ((cr_state == DL) || (cr_state == DR));

endmodule
