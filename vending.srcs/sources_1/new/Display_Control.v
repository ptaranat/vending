`timescale 1ns / 1ps

module Display_Control(
  input clk, reset, [15:0] in, 
  output reg [7:0] digit_select, 
  output reg [3:0] display_out
  );
  reg [1:0] count2;
  always @(posedge clk) begin
    if (reset)
      count2 <= 0;
    else
      count2 <= count2 + 1;
  end
  
  always @(posedge clk) begin
    case(count2)
    2'b00: begin
      digit_select <= 8'b11111110;
      display_out <= in[3:0];
    end
    2'b01: begin
      digit_select <= 8'b11111101;
      display_out <= in[7:4];
    end
    2'b10: begin
      digit_select <= 8'b11111011;
      display_out <= in[11:8];
    end
    2'b11: begin
      digit_select <= 8'b11110111;
      display_out <= in[15:12];
    end
    endcase
  end
endmodule