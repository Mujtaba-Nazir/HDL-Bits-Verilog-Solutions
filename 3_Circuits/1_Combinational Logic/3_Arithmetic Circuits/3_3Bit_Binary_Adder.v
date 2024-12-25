module fadd(input a,b,cin,output sum,cout);
    assign sum=a^b^cin;
    assign cout=(a&b)|(b&cin)|(cin&a);
endmodule
    
    
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    fadd f1(a[0],b[0],cin,sum[0],cout[0]);
    fadd f2(a[1],b[1],cout[0],sum[1],cout[1]);
    fadd f3(a[2],b[2],cout[1],sum[2],cout[2]);
    

endmodule