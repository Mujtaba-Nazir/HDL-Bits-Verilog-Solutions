module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

  parameter[1:0] B1 = 2'b00,B2 = 2'b01,B3 = 2'b10,DONE  = 2'b11;

    reg [1:0] cr_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case(cr_state)
    		B1 : next_state = (in[3]) ? B2 : B1;
    		B2 : next_state = B3;
    		B3 : next_state = DONE;
    		DONE  : next_state = (in[3]) ? B2 : B1;
    	endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) cr_state <= B1;
    	else cr_state <= next_state;
    end
 
    // Output logic
    assign done = (cr_state == DONE);

endmodule