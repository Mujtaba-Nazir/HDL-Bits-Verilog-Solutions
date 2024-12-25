module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); 
 
    parameter OFF=0, ON=1; 
    reg cr_state, next_state;

    always @(*) begin
        // State transition logic
        case(cr_state)
            OFF : next_state = j ? ON : OFF;
            ON : next_state =  k ? OFF : ON;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) cr_state <= OFF;
        else cr_state <= next_state;
    end

   
    assign out = (cr_state == ON);

endmodule
