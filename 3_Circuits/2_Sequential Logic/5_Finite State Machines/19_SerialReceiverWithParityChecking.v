module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    parameter [2:0] idle = 3'b000,start = 3'b001,receive = 3'b010,hold = 3'b011,stop = 3'b100,check = 3'b101;

    reg [2:0] cr_state, next_state;
    reg [3:0] bits;
	reg [7:0] out;
	reg odd_reset;
	reg odd_reg;
	wire odd;	
	

	always @(*) begin
        case(cr_state)
			idle  	: next_state = in ? idle : start;
			start 	: next_state = receive;
            receive : next_state = (bits == 8) ? check : receive;
            check 	: next_state = in ? stop : hold;
            hold 	: next_state = in ? idle : hold;
            stop 	: next_state = in ? idle : start;
		endcase
	end

	always @(posedge clk) begin
        if(reset) cr_state <= idle;
		else cr_state <= next_state;
	end

	always @(posedge clk) begin
		if (reset) begin
			bits <= 0;
		end
		else begin
			case(next_state) 
				receive : begin
					bits = bits + 4'b0001;
				end
				stop : begin
					bits <= 0;
				end
				default : begin
					bits <= 0;
				end
			endcase
		end
	end

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
    	if (reset) out <= 0;
        else if (next_state == receive)
            out[bits] <= in;
    end

    // New: Add parity checking.
    parity u_parity(
        .clk(clk),
        .reset(reset | odd_reset),
        .in(in),
        .odd(odd));  

    always @(posedge clk) begin
    	if(reset) odd_reg <= 0;
    	else odd_reg <= odd; 
    end

    always @(posedge clk) begin
		case(next_state)
			idle : odd_reset <= 1;	
			stop : odd_reset <= 1;
			default : odd_reset <= 0;
		endcase
    end

    assign done = ((cr_state == stop) && odd_reg);
    assign out_byte = (done) ? out : 8'b0;

endmodule
