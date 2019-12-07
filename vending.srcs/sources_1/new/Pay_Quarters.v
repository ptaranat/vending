`timescale 1ns / 1ps

module Pay_Quarters(reset, coin, coin_display_out, coin_out_bin
    );
    
    input reset, coin;
    output reg [15:0] coin_display_out;
    output reg [7:0] coin_out_bin;
    
    reg [2:0] curr_state, next_state;
    
    parameter s0=3'b000, s1=3'b001, s2=3'b010,
              s3=3'b011, s4=3'b100, s5=3'b101,
              s6=3'b110, s7=3'b111;
              
    always @ (posedge reset or posedge coin) begin
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
          coin_display_out=16'b0100000000100101;     // P025
          coin_out_bin=8'b00011001; // 0.25
        end
        
        s1:begin
          next_state=s2;
          coin_display_out=16'b0100000001010000;     // P050
          coin_out_bin=8'b00110010; // 0.50
        end
        
        s2: begin
          next_state=s3;
          coin_display_out=16'b0100000001110101;     // P075
          coin_out_bin=8'b01001011; // $0.75
        end
        
        s3:begin
          next_state=s4;
          coin_display_out=16'b0100000100000000;     // P100
          coin_out_bin=8'b01100100; // $1.00
        end
        
        s4: begin
          next_state=s5;
          coin_display_out=16'b0100000100100101;     // P125
          coin_out_bin=8'b01111101; // $1.25
        end
        
        s5:begin
          next_state=s6;
          coin_display_out=16'b0100000101010000;     // P150
          coin_out_bin=8'b10010110; // $1.50
        end
        
        s6: begin
          next_state=s7;
          coin_display_out=16'b0100000101110101;     // P175
          coin_out_bin=8'b10101111; // 1.75
        end
        
        s7:begin
          next_state=s7;
          coin_display_out=16'b0100001000000000;     // P200
          coin_out_bin=8'b11001000; // $0.75
        end
      endcase
    end // always
endmodule