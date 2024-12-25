module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    parameter [3:0] S0 = 0,S1 = 1,S11= 2, S110= 3, S1101= 4,SH0 = 5, SH1 = 6, SH2 = 7,C0  = 8,D0 = 9; 
	
    reg [3:0] cr_state, next_state;
    reg [9:0] CK; 

	always @(*) begin
        case (cr_state) 
			S0    : next_state = data ? S1    : S0;
			S1    : next_state = data ? S11   : S0;
			S11   : next_state = data ? S11   : S110;
			S110  : next_state = data ? S1101 : S0;
			S1101 : next_state = SH0;
			SH0: next_state = SH1;
			SH1: next_state = SH2;
			SH2: next_state = C0;
            C0 : next_state = (count == 0 & CK == 999) ? D0 : C0;
            D0  : next_state = (ack) ? S0 : D0;			
		endcase
	end

	//state transition
	always @(posedge clk) begin
        if (reset) cr_state <= S0;
		else cr_state <= next_state;
	end

	//shift and down count.
	always @(posedge clk) begin
        case (cr_state) 
			S1101 : count[3] <= data;
			SH0: count[2] <= data;
			SH1: count[1] <= data;
			SH2: count[0] <= data;
			C0 : begin
				if (count >= 0) begin
                    if (CK < 999) 
						CK <= CK + 1'b1;
					else begin
						count <= count - 1'b1;
						CK <= 0;
					end
				end
			end
			default : CK<= 0;
		endcase
	end

    assign counting = (cr_state == C0);
    assign done = (cr_state == D0);


endmodule
