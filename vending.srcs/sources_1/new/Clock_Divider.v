`timescale 1ns / 1ps

module Clock_Divider #(
  parameter FAST = 100000, SLOW = 100000000) (
  input clk, input reset, output reg clk_1khz, clk_1hz
  );
  reg [16:0] count_fast;
  reg [26:0] count_slow;
  always @(posedge clk) begin
    if(reset) begin
      count_fast <= 0;
      count_slow <= 0;
    end
    else if(count_fast == FAST) begin
      clk_1khz <= 1;
      count_fast <= 0;
    end
    else if(count_slow == SLOW) begin
      clk_1hz  <= 1;
      count_slow <= 0;
    end
    else begin
      count_fast <= count_fast + 1;
      count_slow <= count_slow + 1;
      clk_1khz <= 0;
      clk_1hz  <= 0;
    end
  end
endmodule