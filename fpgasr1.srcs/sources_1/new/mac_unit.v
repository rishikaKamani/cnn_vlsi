module mac_unit(
    input clk,
    input rst,
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] result
);

always @(posedge clk or posedge rst) begin
    if (rst)
        result <= 0;
    else
        result <= a * b;
end

endmodule