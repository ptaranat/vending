`timescale 1ns / 1ps

module Top(
  input clk, reset, snack, cost, coin, vend, lever, [1:0] state, output [7:0] digit_select, output [6:0] seven
  );
  wire fastclk;
  wire slowclk;
  wire snack_db;
  wire coin_db;
  wire vend_db;
  wire [15:0] snack_display_out;
  wire [15:0] coin_display_out;
  wire [15:0] cost_display_out;
  wire [15:0] vend_display_out;
  wire  [15:0] display_in;
  
  wire [7:0] cost_out_bin;
  wire [7:0] coin_out_bin;
  
  wire broke;
  
  wire [3:0] display_out;
  
  Clock_Divider          cd(.clk(clk), .reset(reset), .clk_1khz(fastclk), .clk_1hz(slowclk));
  
  Debouncer              db_snack(.clk(clk), .reset(reset), .pb(snack), .pulse(snack_db));
  Snack_Selector         snack_selector(.reset(reset), .snack(snack_db), 
                                        .snack_display_out(snack_display_out), 
                                        .cost_out_bin(cost_out_bin), .cost_display_out(cost_display_out));
                                        
  Debouncer              db_coin(.clk(clk), .reset(reset), .pb(coin), .pulse(coin_db));
  Pay_Quarters           pay_quarters(.reset(reset), .coin(coin_db), .lever(lever),
                                      .coin_display_out(coin_display_out),
                                      .coin_out_bin(coin_out_bin));
  
  Debouncer              db_vend(.clk(clk), .reset(reset), .pb(vend), .pulse(vend_db));                                    
  Vend                   vend_snack(.cost_out_bin(cost_out_bin), .coin_out_bin(coin_out_bin), .vend_display_out(vend_display_out),
                                    .broke(broke));
  
  Controller             controller(.clk(clk), .reset(reset), .snack(snack_db), .coin(coin_db), .cost(cost), .vend(vend_db),
                                    .snack_display_in(snack_display_out), .coin_display_in(coin_display_out),
                                    .cost_display_in(cost_display_out), .vend_display_in(vend_display_out),
                                    .display_out(display_in), .broke(broke));
  
  // TODO make input to DC switch between states
  
  Display_Control        dc(.clk(fastclk), .reset(reset), .in(display_in),  .digit_select(digit_select), .display_out(display_out));
  Seven_Segment ssd(.in(display_out), .out(seven));
endmodule