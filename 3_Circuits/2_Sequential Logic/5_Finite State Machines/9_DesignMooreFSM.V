module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter [2:0]  A  = 3'd0,	   
					 B = 3'd1,	
					 C = 3'd2,	
					 D = 3'd3,	
					 E = 3'd4,	
					 F  = 3'd5;	

    reg [2:0] cr_state, next_state;

	always @(posedge clk) begin
        if(reset) cr_state <= A;
		else cr_state <= next_state;
	end
    always @(*) begin
        case(cr_state)
			A 	:	begin 
                next_state = (s[1]) ? C : A;
                {fr3, fr2, fr1, dfr} = 4'b1111;
            end
			B 	: begin
                next_state = (s[2]) ? E : ((s[1]) ? B : A);
                {fr3, fr2, fr1, dfr} = 4'b0111; 
            end
			C	:begin
                next_state = (s[2]) ? E : ((s[1]) ? C : A);
                {fr3, fr2, fr1, dfr} = 4'b0110;
            end
			D	:	begin
                next_state = (s[3]) ? F  : ((s[2]) ? D : B);
                {fr3, fr2, fr1, dfr} = 4'b0011;
            end
			E	:	begin
                next_state = (s[3]) ? F  : ((s[2]) ? E : B);
                {fr3, fr2, fr1, dfr} = 4'b0010;
            end
			F 	:	begin 
                next_state = (s[3]) ? F  : D;
                {fr3, fr2, fr1, dfr} = 4'b0000;
            end
			default : begin 
                next_state = 3'bxxx;
                {fr3, fr2, fr1, dfr} = 4'bxxxx;
            end
		endcase
	end


endmodule
