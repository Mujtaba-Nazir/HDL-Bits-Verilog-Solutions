module top_module (
    input clk,
    input reset,        
    output [3:0] q);
    always@(posedge clk)
        begin
            if(reset||(q==4'b1001))
                q<=0;
            else
                q<=q+1'b1;
        end

endmodule