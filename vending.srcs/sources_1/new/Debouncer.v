`timescale 1ns / 1ps

module Debouncer #(
  parameter COUNT_MAX = 9600) (
  input clk, input reset, input pb, output reg pulse
  );
  reg [31:0] count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
    end
    else if (pb)
      count <= count + 1;
    else
      count <= 0;
  end
  always @(posedge clk) begin
    if (reset)
      pulse <= 1'b0;
    else if (count == COUNT_MAX)
      pulse <= 1'b1;
    else begin
      pulse <= 1'b0;
    end
  end
endmodule
