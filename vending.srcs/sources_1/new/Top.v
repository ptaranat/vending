`timescale 1ns / 1ps

module Top(
  input clk, reset, snack, cost, coin, vend, [1:0] state, output [3:0] digit_select, output [6:0] seven
  );
  wire fastclk;
  wire slowclk;
  wire snack_db;
  wire coin_db;
  wire [15:0] snack_display_out;
  wire [15:0] coin_display_out;
  reg  [15:0] display_in;
  
  wire [7:0] cost_out_bin;
  wire [7:0] coin_out_bin;
  
  wire [3:0] display_out;
  
  Clock_Divider          cd(.clk(clk), .reset(reset), .clk_1khz(fastclk), .clk_1hz(slowclk));
  
  Debouncer              db_snack(.clk(clk), .reset(reset), .pb(snack), .pulse(snack_db));
  Snack_Selector         snack_selector(.reset(reset), .snack(snack_db), 
                                        .snack_display_out(snack_display_out), 
                                        .cost_out_bin(cost_out_bin));
                                        
  Debouncer              db_coin(.clk(clk), .reset(reset), .pb(coin), .pulse(coin_db));
  Pay_Quarters           pay_quarters(.reset(reset), .coin(coin_db),
                                      .coin_display_out(coin_display_out),
                                      .coin_out_bin(coin_out_bin));
  
  // TODO make input to DC switch between states
  
  Display_Control        dc(.clk(fastclk), .reset(reset), .in(display_in),  .digit_select(digit_select), .display_out(display_out));
  Seven_Segment ssd(.in(display_out), .out(seven));
  
  
  /*
  always@(*) begin
      case(state)
      2'b00: begin
        display_in <= snack_display_out;
      end
      2'b01: begin
        display_in <= coin_display_out;
      end
      default: begin
        display_in <= snack_display_out;
      end
      endcase
  end
  */
endmodule