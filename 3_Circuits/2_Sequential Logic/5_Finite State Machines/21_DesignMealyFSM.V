module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    parameter [1:0] S0 = 0,S1 = 1,S10 = 2;

    reg [1:0] cr_state, next_state;

	always @(*) begin
        case (cr_state)
			S0 : begin 
				next_state = x ? S1 : S0;
				z = 0;
			end
			S1 : begin
				next_state = x ? S1 : S10;
				z = 0;
			end
			S10 : begin
				if (x) begin
					next_state = S1;
					z = 1;
				end
				else begin
					next_state = S0;
					z = 0;
				end
			end
		endcase
	end

	always @(posedge clk or negedge aresetn) begin
        if (~aresetn) cr_state <= S0;
		else cr_state <= next_state;
	end
endmodule
