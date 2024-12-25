module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter [2:0] idle = 3'b000,start = 3'b001,receive = 3'b010,hold = 3'b011,stop = 3'b100;

    reg [2:0] cr_state, next_state;
    reg [3:0] bits;
	reg [7:0] out;

	always @(*) begin
        case(cr_state)
			idle  : next_state = in ? idle : start;
			start : next_state = receive;
			receive : begin
                if (bits == 8) begin
                    if (in) next_state = stop;
					else next_state = hold;
				end 
				else next_state = receive;			
			end
			hold : next_state = in ? idle : hold;
            stop : next_state = in ? idle : start;
		endcase
	end

	always @(posedge clk) begin
        if(reset) cr_state <= idle;
		else cr_state <= next_state;
	end

	always @(posedge clk) begin
		if (reset) begin
			done <= 0;
			bits <= 0;
		end
		else begin
			case(next_state) 
				receive : begin
					done <= 0;
					bits = bits + 4'b0001;
				end
				stop : begin
					done <= 1;
					bits <= 0;
				end
				default : begin
					done <= 0;
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

    assign out_byte = done ? out : 8'b0;

endmodule
