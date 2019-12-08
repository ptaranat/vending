`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2019 10:14:46 PM
// Design Name: 
// Module Name: segment_clear
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module segment_clear(output reg [6:0] h0, h1, h2, h3);
  // parameter
    parameter off = 7'b1111111;

    // always
    always @(*) begin
        h0 <= off;
        h1 <= off;
        h2 <= off;
        h3 <= off;
    end
endmodule
