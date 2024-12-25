module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    parameter [3:0] B0 = 0,B1  = 1,B2 = 2,B3= 3,B4 = 4,B5 = 5,B6= 6,discard = 7,flg = 8,error  = 9;

    reg [3:0] cr_state, next_state;

	always @(*) begin
        case (cr_state)
            B0 : next_state = in ? B1 : B0;
			B1 : next_state = in ? B2 : B0;
			B2 : next_state = in ? B3 : B0;
			B3 : next_state = in ? B4 : B0;
			B4 : next_state = in ? B5 : B0;
			B5 : next_state = in ? B6 : discard;
			B6 : next_state = in ? error : flg;
			discard : next_state = in ? B1 : B0;
			flg : next_state = in ? B1 : B0;
			error: next_state = in ? error : B0;
		endcase
	end 

	always @(posedge clk) begin
		if (reset)
		cr_state<= B0;
		else 
			cr_state <= next_state;
	end

    assign disc = (cr_state == discard);
    assign flag = (cr_state == flg);
    assign err = (cr_state == error);

endmodule
