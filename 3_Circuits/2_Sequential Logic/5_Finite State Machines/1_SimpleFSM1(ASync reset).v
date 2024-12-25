module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg cr_state, next_state;

    always @(*) begin    // Combinational always block
        // State transition logic
        case(cr_state)
            A : next_state = in ? A : B;
            B : next_state = in ? B : A;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // Sequential always block
        // State flip-flops with asynchronous reset
        if(areset) cr_state <= B;
        else cr_state <= next_state;
    end

    // Output logic
    assign out = (cr_state == B);
endmodule
