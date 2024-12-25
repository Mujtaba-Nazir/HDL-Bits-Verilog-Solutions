module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire x,y,z;
    bcd_fadd f1(a[3:0],b[3:0],cin,x,sum[3:0]);
    bcd_fadd f2(a[7:4],b[7:4],x,y,sum[7:4]);
    bcd_fadd f3(a[11:8],b[11:8],y,z,sum[11:8]);
    bcd_fadd f4(a[15:12],b[15:12],z,cout,sum[15:12]);

endmodule
