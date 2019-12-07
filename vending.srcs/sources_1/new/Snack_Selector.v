`timescale 1ns / 1ps

module Snack_Selector(reset, snack_button, snack_out, cost_out
    );
    
    input reset, snack_button;
    output reg [7:0] snack_out;
    output reg [11:0] cost_out;
    
    reg [2:0] curr_state, next_state;
    
    parameter s0=3'b000, s1=3'b001, s2=3'b010,
              s3=3'b011, s4=3'b100, s5=3'b101,
              s6=3'b110, s7=3'b111;
              
    always @ (posedge reset or posedge snack_button) begin
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
          snack_out=8'b10100001;     // A1
          cost_out=12'b000100000000; // $1.00
        end
        
        s1:begin
          next_state=s2;
          snack_out=8'b10100010;     // A2
          cost_out=12'b000100000000; // $1.00
        end
        
        s2: begin
          next_state=s3;
          snack_out=8'b10100011;     // A3
          cost_out=12'b000001110101; // $0.75
        end
        
        s3:begin
          next_state=s4;
          snack_out=8'b10110001;     // b1
          cost_out=12'b000100100101; // $1.25
        end
        
        s4: begin
          next_state=s5;
          snack_out=8'b10110010;     // b2
          cost_out=12'b000100000000; // $1.00
        end
        
        s5:begin
          next_state=s6;
          snack_out=8'b10110011;     // b3
          cost_out=12'b000100100101; // $1.25
        end
        
        s6: begin
          next_state=s7;
          snack_out=8'b11000001;     // C1
          cost_out=12'b000001110101; // $0.75
        end
        
        s7:begin
          next_state=s0;
          snack_out=8'b11000010;     // C
          cost_out=12'b000001110101; // $0.75
        end
        
      endcase
    end// always
endmodule
