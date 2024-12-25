module top_module (input x, input y, output z);
wire a,b,c,d,e,f;
    assign a=(x^y)&x;
    assign b=~(x^y);
    assign c=a|b;
    assign d=a;
    assign e=b;
    assign f=d&b;
    assign z=c^f;
endmodule