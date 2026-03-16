module predictor(
    input [15:0] avg_pixel,
    output prediction
);

parameter THRESHOLD = 16'd170;

assign prediction = (avg_pixel > THRESHOLD) ? 1'b1 : 1'b0;

endmodule