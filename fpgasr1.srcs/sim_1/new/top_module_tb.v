`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 16:21:58
// Design Name: 
// Module Name: top_module_tb
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


`timescale 1ns / 1ps

module top_module_tb;

reg clk;
reg rst;
wire [7:0] cnn_output;


/* Instantiate the Top Module */

top_module uut (
    .clk(clk),
    .rst(rst),
    .cnn_output(cnn_output)
);


/* Clock Generation */

initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 10ns clock period
end


/* Reset and Simulation Control */

initial begin

    rst = 1;
    #20;

    rst = 0;

    #5000;   // run simulation for some time

    $stop;

end


/* Monitor Output */

initial begin
    $monitor("Time = %0t | CNN Output = %d", $time, cnn_output);
end

endmodule
