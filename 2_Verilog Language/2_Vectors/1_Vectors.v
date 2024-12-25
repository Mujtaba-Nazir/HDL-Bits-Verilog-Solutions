module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  );

    assign outv[2:0]=vec[2:0];
    assign {o2,o1,o0}={vec[2],vec[1],vec[0]};
    

endmodule