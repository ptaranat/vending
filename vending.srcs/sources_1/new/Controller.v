`timescale 1ns / 1ps
module Controller(clk, reset, snack, coin, 
                  cost, vend, snack_display_in, 
                  coin_display_in, cost_display_in,
                  vend_display_in, display_out, broke
    );
    
    input clk, reset, broke, snack, coin, cost, vend;
    input [15:0] snack_display_in, coin_display_in, cost_display_in, vend_display_in;
    
    output reg [15:0] display_out;
    
    reg [1:0] prev_state,state, next_state;
    
    // s0= snack, s1= display cost, s2=input quarters, s3=vend
    parameter s0=2'b00, s1=2'b01,
              s2=2'b10, s3=2'b11;
    initial begin
      state <= s0;
      next_state <= s0;
    end
    always @(posedge clk or posedge reset) begin
      if (reset) begin
        state<= s0;
      end
      else begin
        state <= next_state;
      end
    end

    always @(state or snack or coin or cost or vend) begin
      if (reset) begin
        display_out<= snack_display_in;
      end
      else begin
        case (state)
        s0 : if (cost) begin
          display_out <= cost_display_in;
        end
        else if (coin) begin
          next_state <= s2;
          display_out<= coin_display_in;
        end
        else begin
          display_out<= snack_display_in;
          next_state <= s0;
        end
        s2 : if (cost) begin
          display_out <= cost_display_in;
        end
        else if (vend) begin
          next_state <= s3;
          display_out<= vend_display_in;
        end
        else if (snack) begin
          next_state <= s0;
        end
        else begin
          display_out<= coin_display_in;
          next_state <= s2;
        end
        s3 : if (cost) begin
          display_out <= cost_display_in;
        end
        else if (coin) begin
          next_state <= s2;
        end
        else if (snack) begin
          next_state <= s0;
        end
        else begin
          display_out <= vend_display_in;
          next_state <= s3;
        end
        endcase
      end
    end
    
endmodule
