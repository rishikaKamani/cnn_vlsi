module fc_layer(
    input clk,
    input rst,
    input signed [15:0] in_data,
    output reg signed [15:0] class0,
    output reg signed [15:0] class1
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        class0 <= 0;
        class1 <= 0;
    end
    else begin
        class0 <= in_data;       // normal score
        class1 <= in_data >> 1;  // leukemia score
    end
end

endmodule