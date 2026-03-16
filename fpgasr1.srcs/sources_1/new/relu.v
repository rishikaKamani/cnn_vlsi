module relu(
    input signed [15:0] in_data,
    output signed [15:0] out_data
);

assign out_data = (in_data > 0) ? in_data : 0;

endmodule