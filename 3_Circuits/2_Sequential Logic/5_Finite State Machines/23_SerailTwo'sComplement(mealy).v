module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter a=0,b=1;
    reg cr_state,next_state;
    
    always@(*) begin
        case(cr_state)
            a: next_state = x ? b:a;
            b: next_state = x?b:b;
        endcase
    end
    
    always@(posedge clk or posedge areset) begin
        if (areset) 
            cr_state <= a;
        else
            cr_state <= next_state; 
    end
    
    assign z = (cr_state == a) & x || (cr_state == b) & ~x;

endmodule
