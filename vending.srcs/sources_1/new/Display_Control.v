`timescale 1ns / 1ps

module Display_Control(
  input clk, [15:0] count, reset, output reg [3:0] digit_select, output reg [3:0] seven
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
      digit_select <= 4'b1110;
      seven <= count[3:0];
    end
    2'b01: begin
      digit_select <= 4'b1101;
      seven <= count[7:4];
    end
    2'b10: begin
      digit_select <= 4'b1011;
      seven <= count[11:8];
    end
    2'b11: begin
      digit_select <= 4'b0111;
      seven <= count[15:12];
    end
    default: begin
      digit_select <= 4'b1110;
      seven <= count[3:0];
    end
    endcase
  end
endmodule