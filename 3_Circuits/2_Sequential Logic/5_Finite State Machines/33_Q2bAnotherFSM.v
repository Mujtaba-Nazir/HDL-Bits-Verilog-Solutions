module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    parameter S0=4'd0, S1=4'd1, S2=4'd2, S3=4'd3, S4=4'd4, S5=4'd5, S6=4'd6, S7=4'd7, S8=4'd8;
    reg [3:0] cr_state, next_state;
    
    always@(*) begin
        case(cr_state)
            S0 : next_state = resetn ? S1 : S0;
            S1 : next_state = S2;
            S2 : next_state = x ? S3 : S2;
            S3 : next_state = x ? S3 : S4;
            S4 : next_state = x ? S5 : S2;
			S5 : next_state = y ? S6 : S7;
            S6 : next_state = resetn ? S6 : S0;
            S7 : next_state = y ? S6 : S8;
  	        S8:  next_state = resetn ? S8 : S0;
        endcase
    end
    
    always@(posedge clk) begin
        if(~resetn)
            cr_state <= S0;
        else
            cr_state <= next_state;
    end
    
    always@(posedge clk) begin
        case(next_state)
            S1:     f <= 1'b1;
            S5:		g <= 1'b1;
            S7:	g <= 1'b1;
            S6:    g <= 1'b1;
            S8:    g <= 1'b0;
            default: begin
                    f <= 1'b0;
                    g <= 1'b0;
            end
        endcase
    end

endmodule
