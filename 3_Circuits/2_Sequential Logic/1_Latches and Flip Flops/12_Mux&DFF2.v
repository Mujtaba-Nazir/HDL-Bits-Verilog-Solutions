module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    always@(posedge clk)
        begin
            case(E)
                    1'b0: case(L)
                        	1'b0:Q<=Q;
                        	1'b1:Q<=R;
                   		 endcase
                1'b1:case(L)
                    1'b0:Q<=w;
                    1'b1:Q<=R;
               		 endcase
            endcase
        end
                        
                
                    
                    

endmodule