module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    wire a;
    assign out=(in3^a);
    assign a=in1~^in2;
    

endmodule