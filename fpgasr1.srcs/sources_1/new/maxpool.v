`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2026 15:16:58
// Design Name: 
// Module Name: maxpool
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

module maxpool(
    input signed [15:0] a,
    input signed [15:0] b,
    input signed [15:0] c,
    input signed [15:0] d,
    output signed [15:0] max_out
);

wire signed [15:0] max1;
wire signed [15:0] max2;

assign max1 = (a > b) ? a : b;
assign max2 = (c > d) ? c : d;
assign max_out = (max1 > max2) ? max1 : max2;

endmodule
