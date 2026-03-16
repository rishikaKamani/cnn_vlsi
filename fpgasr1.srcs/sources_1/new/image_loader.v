`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 15:24:53
// Design Name: 
// Module Name: image_loader
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


module image_loader(
    input clk,
    input rst,
    output reg [7:0] pixel_out
);

reg [7:0] image_mem [0:255];
integer i = 0;

initial begin
image_mem[0]=8'd0; image_mem[1]=8'd0; image_mem[2]=8'd0; image_mem[3]=8'd0;
image_mem[4]=8'd0; image_mem[5]=8'd0; image_mem[6]=8'd0; image_mem[7]=8'd0;
image_mem[8]=8'd0; image_mem[9]=8'd0; image_mem[10]=8'd0; image_mem[11]=8'd0;
image_mem[12]=8'd0; image_mem[13]=8'd0; image_mem[14]=8'd0; image_mem[15]=8'd0;

image_mem[16]=8'd0; image_mem[17]=8'd5; image_mem[18]=8'd12; image_mem[19]=8'd18;
image_mem[20]=8'd22; image_mem[21]=8'd25; image_mem[22]=8'd24; image_mem[23]=8'd20;
image_mem[24]=8'd15; image_mem[25]=8'd10; image_mem[26]=8'd5; image_mem[27]=8'd0;

image_mem[32]=8'd0; image_mem[33]=8'd10; image_mem[34]=8'd35; image_mem[35]=8'd60;
image_mem[36]=8'd85; image_mem[37]=8'd95; image_mem[38]=8'd92; image_mem[39]=8'd80;
image_mem[40]=8'd65; image_mem[41]=8'd40; image_mem[42]=8'd20; image_mem[43]=8'd5;

image_mem[48]=8'd0; image_mem[49]=8'd25; image_mem[50]=8'd70; image_mem[51]=8'd110;
image_mem[52]=8'd140; image_mem[53]=8'd155; image_mem[54]=8'd150; image_mem[55]=8'd135;

image_mem[64]=8'd0; image_mem[65]=8'd40; image_mem[66]=8'd100; image_mem[67]=8'd150;
image_mem[68]=8'd185; image_mem[69]=8'd200; image_mem[70]=8'd195; image_mem[71]=8'd175;

image_mem[80]=8'd0; image_mem[81]=8'd50; image_mem[82]=8'd120; image_mem[83]=8'd180;
image_mem[84]=8'd220; image_mem[85]=8'd235; image_mem[86]=8'd228; image_mem[87]=8'd205;

image_mem[96]=8'd0; image_mem[97]=8'd45; image_mem[98]=8'd115; image_mem[99]=8'd175;
image_mem[100]=8'd215; image_mem[101]=8'd230; image_mem[102]=8'd225; image_mem[103]=8'd205;

image_mem[112]=8'd0; image_mem[113]=8'd30; image_mem[114]=8'd90; image_mem[115]=8'd145;
image_mem[116]=8'd180; image_mem[117]=8'd200; image_mem[118]=8'd195; image_mem[119]=8'd170;

image_mem[128]=8'd0; image_mem[129]=8'd15; image_mem[130]=8'd60; image_mem[131]=8'd105;
image_mem[132]=8'd140; image_mem[133]=8'd155; image_mem[134]=8'd150; image_mem[135]=8'd130;

image_mem[144]=8'd0; image_mem[145]=8'd5; image_mem[146]=8'd30; image_mem[147]=8'd65;
image_mem[148]=8'd90; image_mem[149]=8'd105; image_mem[150]=8'd100; image_mem[151]=8'd85;

image_mem[160]=8'd0; image_mem[161]=8'd0; image_mem[162]=8'd10; image_mem[163]=8'd30;
image_mem[164]=8'd45; image_mem[165]=8'd55; image_mem[166]=8'd52; image_mem[167]=8'd45;

image_mem[176]=8'd0; image_mem[177]=8'd0; image_mem[178]=8'd0; image_mem[179]=8'd5;
image_mem[180]=8'd12; image_mem[181]=8'd18; image_mem[182]=8'd16; image_mem[183]=8'd12;

end


always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        i <= 0;
        pixel_out <= 0;
    end
    else
    begin
        pixel_out <= image_mem[i];

        if(i == 255)
            i <= 0;
        else
            i <= i + 1;
    end
end

endmodule