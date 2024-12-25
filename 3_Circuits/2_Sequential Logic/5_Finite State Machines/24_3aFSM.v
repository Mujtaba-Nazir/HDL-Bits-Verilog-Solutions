module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 0, B = 1;

 reg cr_state, next_state;
    reg [1:0] C0,C1;
   

    always @(*) begin
        case(cr_state)
   			A : next_state = s ? B : A;
   			B : next_state = B;
  endcase
 end

 always @(posedge clk) begin
  if (reset) begin
   cr_state <= A;
            C0=0;
            C1=0;
  end
  else begin 
      cr_state <= next_state;
        
      if(cr_state==B)
            begin
                if(C1==3)begin
                    C0=0;
                    C1=0;
                end
                if(w==1) C0=C0+1;
                
                    C1=C1+1;
                
             end
    end
 end    

 

    assign z = ((C0 == 2) & (C1 == 3) );

endmodule
