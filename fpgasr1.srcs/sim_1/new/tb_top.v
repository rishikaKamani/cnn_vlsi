`timescale 1ns / 1ps

module tb_top;

reg clk;
reg rst;

wire signed [15:0] class0;
wire signed [15:0] class1;
wire prediction;

/* Instantiate Top Module */

top_module uut (
    .clk(clk),
    .rst(rst),
    .class0(class0),
    .class1(class1),
    .prediction(prediction)
);

/* Clock generation */

initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 10ns clock period
end


/* Reset control */

initial begin
    rst = 1;
    #20;
    rst = 0;

    #200000;   // allow time for full image processing
    $finish;   // simulation stops automatically
end


/* Monitor values */

initial begin
    $monitor("time=%0t avg_pixel=%d prediction=%d",
             $time, uut.avg_pixel, prediction);
end


/* Display final diagnosis */

always @(prediction) begin
    if(prediction)
        $display("RESULT : Leukemia Detected");
    else
        $display("RESULT : Normal Blood Sample");
end


endmodule