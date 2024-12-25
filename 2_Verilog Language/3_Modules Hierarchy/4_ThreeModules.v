module top_module ( input clk, input d, output q );
    wire x,y;
    my_dff ins1(.clk(clk),.d(d),.q(x));
    my_dff ins2(.clk(clk),.d(x),.q(y));
    my_dff ins3(.clk(clk),.d(y),.q(q));
    
    
endmodule
