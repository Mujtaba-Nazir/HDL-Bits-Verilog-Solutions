// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

parameter A = 0, B = 1;
    reg cr_state, next_state;

    always @(posedge clk) begin
        if (reset)
            cr_state <=  B;
        else  
            cr_state <= next_state;
    end
       
    always @(*) begin
        case (cr_state)
            B : next_state <= in ? B : A;
            A : next_state <= in ? A : B;
        endcase
    end
        
    assign out = (cr_state == B);

endmodule
