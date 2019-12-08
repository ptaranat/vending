`timescale 1ns / 1ps

module Vend(cost_out_bin, coin_out_bin, vend_display_out, broke);
  input [7:0] cost_out_bin;
  input [7:0] coin_out_bin;
  output reg [15:0] vend_display_out;
  output reg broke;
  parameter r=4'b0110;
  integer cost, coin;
  reg [7:0] change;
  wire [11:0] bcd_change;
  
  bin2bcd b2b(.bin(change), .bcd(bcd_change));
  initial begin
    broke <= 0;
  end
  
  always @(cost_out_bin or coin_out_bin) begin
    cost = cost_out_bin;
    coin = coin_out_bin;
    if (cost > coin) begin
      vend_display_out <= 16'b0100100110010110; // Poor
      broke <= 1;
    end else begin
      change = coin_out_bin - cost_out_bin;
      vend_display_out = {r, bcd_change}; //r150
      broke <= 0;
    end
  end
endmodule
