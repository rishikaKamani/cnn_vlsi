`timescale 1ns / 1ps
module top_module(
    input clk,
    input rst,
    output signed [15:0] class0,
    output signed [15:0] class1,
    output prediction
);

// Image memory
reg [7:0] image_mem [0:255];
reg [7:0] pixel;
reg [7:0] addr;

// Pixel statistics
reg [23:0] sum_pixels;
reg [15:0] avg_pixel;

// Intermediate wires
wire signed [15:0] mac_out;
wire signed [15:0] relu_out;
wire signed [15:0] pool_out;

/* IMAGE INPUT */
initial begin
    $readmemh("dataset1.mem", image_mem);
    $display("Pixel0 = %d", image_mem[0]);
    $display("Pixel1 = %d", image_mem[1]);
    $display("Pixel2 = %d", image_mem[2]);
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        addr <= 0;
        pixel <= 0;
        sum_pixels <= 0;
        avg_pixel <= 0;
    end
    else begin
        pixel <= image_mem[addr];
        sum_pixels <= sum_pixels + image_mem[addr];

        if(addr == 8'd255) begin
            avg_pixel <= (sum_pixels + image_mem[addr]) >> 8;
            $display("FINAL AVG = %d", (sum_pixels + image_mem[addr]) >> 8);

            addr <= 0;
            sum_pixels <= 0;
        end
        else begin
            addr <= addr + 1;
        end
    end
end

/* MAC layer */
mac_unit mac_inst (
    .clk(clk),
    .rst(rst),
    .a(pixel),
    .b(8'd3),
    .result(mac_out)
);

/* RELU */
relu relu_inst (
    .in_data(mac_out),
    .out_data(relu_out)
);

/* MAXPOOL */
maxpool pool_inst (
    .a(relu_out),
    .b(relu_out),
    .c(relu_out),
    .d(relu_out),
    .max_out(pool_out)
);

/* Fully connected */
fc_layer fc_inst (
    .clk(clk),
    .rst(rst),
    .in_data(pool_out),
    .class0(class0),
    .class1(class1)
);

/* Predictor */
predictor pred_inst (
    .avg_pixel(avg_pixel),
    .prediction(prediction)
);
endmodule