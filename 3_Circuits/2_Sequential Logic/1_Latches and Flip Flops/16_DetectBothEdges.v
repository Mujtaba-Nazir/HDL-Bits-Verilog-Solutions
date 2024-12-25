module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] Q_last;
  always @(posedge clk) begin
      Q_last <= in;
      anyedge <= in ^ Q_last;
  end 
endmodule
