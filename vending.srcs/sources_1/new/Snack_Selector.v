`timescale 1ns / 1ps

module Snack_Selector(reset, snack, snack_display_out, cost_out_bin,
    );
    
    input reset, snack;
    output reg [15:0] snack_display_out;
    output reg [7:0] cost_out_bin;
    
    reg [2:0] curr_state, next_state;
    
    parameter s0=3'b000, s1=3'b001, s2=3'b010,
              s3=3'b011, s4=3'b100, s5=3'b101,
              s6=3'b110, s7=3'b111;
              
    always @ (posedge reset or posedge snack) begin
      if (reset) begin
        curr_state<=s0;
      end
      else begin
        curr_state<=next_state;
      end
    end // always
    
    always @ (*) begin
      case(curr_state)
        s0: begin
          next_state=s1;
          snack_display_out=16'b1010000111111111;     // A1
          cost_out_bin=8'b01100100; // $1.00
        end
        
        s1:begin
          next_state=s2;
          snack_display_out=16'b1010001011111111;     // A2
          cost_out_bin=8'b01100100; // $1.00
        end
        
        s2: begin
          next_state=s3;
          snack_display_out=16'b1010001111111111;     // A3
          cost_out_bin=8'b01001011; // $0.75
        end
        
        s3:begin
          next_state=s4;
          snack_display_out=16'b1011000111111111;     // b1
          cost_out_bin=8'b01111101; // $1.25
        end
        
        s4: begin
          next_state=s5;
          snack_display_out=16'b1011001011111111;     // b2
          cost_out_bin=8'b01100100; // $1.00
        end
        
        s5:begin
          next_state=s6;
          snack_display_out=16'b1011001111111111;     // b3
          cost_out_bin=8'b01111101; // $1.25
        end
        
        s6: begin
          next_state=s7;
          snack_display_out=16'b1100000111111111;     // C1
          cost_out_bin=8'b01001011; // $0.75
        end
        
        s7:begin
          next_state=s0;
          snack_display_out=16'b1100001011111111;     // C2
          cost_out_bin=8'b01001011; // $0.75
        end
        
      endcase
    end// always
endmodule
