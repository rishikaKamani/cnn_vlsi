`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2026 15:14:50
// Design Name: 
// Module Name: conv3x3
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

module conv3x3(
    input clk,
    input rst,
    input start,
    input signed [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,
    input signed [7:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,
    output reg signed [15:0] result,
    output reg done
);

reg signed [15:0] acc;
reg [3:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
        count <= 0;
        done <= 0;
    end
    else if (start) begin
        case(count)
            0: acc <= p0*w0;
            1: acc <= acc + p1*w1;
            2: acc <= acc + p2*w2;
            3: acc <= acc + p3*w3;
            4: acc <= acc + p4*w4;
            5: acc <= acc + p5*w5;
            6: acc <= acc + p6*w6;
            7: acc <= acc + p7*w7;
            8: acc <= acc + p8*w8;
        endcase

        if (count == 8) begin
            result <= acc;
            done <= 1;
            count <= 0;
        end
        else begin
            count <= count + 1;
            done <= 0;
        end
    end
end

endmodule
