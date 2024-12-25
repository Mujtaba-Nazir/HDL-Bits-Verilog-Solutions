module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    parameter [1:0] WL = 2'b00,
					WR = 2'b01,
					FL = 2'b10,
 					FR = 2'b11;

    reg [1:0] cr_state, next_state;

 	always @(posedge clk or posedge areset) begin
        if(areset) cr_state <= WL;
 		else begin
 			cr_state <= next_state;
 		end
 	end

 	always @(*) begin
        case(cr_state)
            WL : next_state = ground ? (bump_left ? WR : WL) : FL ;
            WR : next_state = ground ? (bump_right? WL : WR): FR;
 			FL : next_state = ground ? WL : FL;
 			FR : next_state = ground ? WR : FR;
 		endcase
 	end

    assign walk_left = (cr_state==WL);
    assign walk_right = (cr_state==WR);
    assign aaah=((cr_state==FL) || (cr_state==FR));



endmodule
