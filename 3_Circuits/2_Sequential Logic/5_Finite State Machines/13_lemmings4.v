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
                     DR  = 3'b101,
                     splat = 3'b110;

    reg [2:0] cr_state, next_state;
    reg [7:0] clock_count;

    always @(posedge clk or posedge areset) begin
        if(areset) cr_state <= WL;
        else if(cr_state == FR || cr_state == FL) begin
            clock_count <= clock_count + 1;
            cr_state <= next_state;
        end
        else begin
            cr_state <= next_state;
            clock_count <= 0;
        end       
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
            FL : begin
                if(ground) begin
                    if(clock_count > 19) next_state = splat;
                    else next_state = WL;
                end
                else next_state = FL;
            end
            FR : begin
                if(ground) begin
                    if(clock_count > 19) next_state = splat;
                    else next_state = WR;
                end
                else next_state = FR;
            end
            DL  : next_state = ground ? DL : FL;
            DR  : next_state = ground ? DR : FR;
            splat : next_state = splat;
        endcase
    end

    assign walk_left = (cr_state == WL);
    assign walk_right = (cr_state == WR);
    assign aaah = ((cr_state == FL) || (cr_state == FR));
    assign digging = ((cr_state == DL) || (cr_state == DR));

endmodule
