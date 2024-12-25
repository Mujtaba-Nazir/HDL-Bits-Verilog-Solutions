module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] y,z;
    wire x;
    add16 ins1 (.a(a[15:0]),.b(b[15:0]),.sum(sum[15:0]),.cout(x));
    add16 ins2 (.a(a[31:16]),.b(b[31:16]),.sum(y),.cin({16{1'b0}}));
    add16 ins3 (.a(a[31:16]),.b(b[31:16]),.sum(z),.cin({16{1'b1}}));
    assign sum[31:16]={(y&{16{(~x)}})|(z&{16{x}})};
endmodule
