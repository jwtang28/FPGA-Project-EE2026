`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 00:17:20
// Design Name: 
// Module Name: mount
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


module mount(bgclk, over, x, y, rand, en3, mount_data, sel);

    input bgclk,over,sel;
    input [2:0]rand;
    input [6:0]x, y;
    output reg en3;
    output reg [15:0] mount_data;

    reg[63:0]bg[95:0];
    reg [63:0]mt = 1073741823;
    reg [6:0]height = 0;
    reg [6:0]limit = 0;
    reg dir=0;

    always @(posedge bgclk) begin
        if(~over) begin
            if(height == limit) begin
                if (dir) begin
                    dir = 0;
                    limit = 23 + rand[2:0];
                end
                else begin
                    dir = 1;
                    limit = rand[2:0];
                end
            end
            height <= (dir)? height - 1: height + 1;
            bg[95] <= mt >> height;
            bg[94] <= bg[95];
            bg[93] <= bg[94];
            bg[92] <= bg[93];
            bg[91] <= bg[92];
            bg[90] <= bg[91];
            bg[89] <= bg[90];
            bg[88] <= bg[89];
            bg[87] <= bg[88];
            bg[86] <= bg[87];
            bg[85] <= bg[86];
            bg[84] <= bg[85];
            bg[83] <= bg[84];
            bg[82] <= bg[83];
            bg[81] <= bg[82];
            bg[80] <= bg[81];
            bg[79] <= bg[80];
            bg[78] <= bg[79];
            bg[77] <= bg[78];
            bg[76] <= bg[77];
            bg[75] <= bg[76];
            bg[74] <= bg[75];
            bg[73] <= bg[74];
            bg[72] <= bg[73];
            bg[71] <= bg[72];
            bg[70] <= bg[71];
            bg[69] <= bg[70];
            bg[68] <= bg[69];
            bg[67] <= bg[68];
            bg[66] <= bg[67];
            bg[65] <= bg[66];
            bg[64] <= bg[65];
            bg[63] <= bg[64];
            bg[62] <= bg[63];
            bg[61] <= bg[62];
            bg[60] <= bg[61];
            bg[59] <= bg[60];
            bg[58] <= bg[59];
            bg[57] <= bg[58];
            bg[56] <= bg[57];
            bg[55] <= bg[56];
            bg[54] <= bg[55];
            bg[53] <= bg[54];
            bg[52] <= bg[53];
            bg[51] <= bg[52];
            bg[50] <= bg[51];
            bg[49] <= bg[50];
            bg[48] <= bg[49];
            bg[47] <= bg[48];
            bg[46] <= bg[47];
            bg[45] <= bg[46];
            bg[44] <= bg[45];
            bg[43] <= bg[44];
            bg[42] <= bg[43];
            bg[41] <= bg[42];
            bg[40] <= bg[41];
            bg[39] <= bg[40];
            bg[38] <= bg[39];
            bg[37] <= bg[38];
            bg[36] <= bg[37];
            bg[35] <= bg[36];
            bg[34] <= bg[35];
            bg[33] <= bg[34];
            bg[32] <= bg[33];
            bg[31] <= bg[32];
            bg[30] <= bg[31];
            bg[29] <= bg[30];
            bg[28] <= bg[29];
            bg[27] <= bg[28];
            bg[26] <= bg[27];
            bg[25] <= bg[26];
            bg[24] <= bg[25];
            bg[23] <= bg[24];
            bg[22] <= bg[23];
            bg[21] <= bg[22];
            bg[20] <= bg[21];
            bg[19] <= bg[20];
            bg[18] <= bg[19];
            bg[17] <= bg[18];
            bg[16] <= bg[17];
            bg[15] <= bg[16];
            bg[14] <= bg[15];
            bg[13] <= bg[14];
            bg[12] <= bg[13];
            bg[11] <= bg[12];
            bg[10] <= bg[11];
            bg[9] <= bg[10];
            bg[8] <= bg[9];
            bg[7] <= bg[8];
            bg[6] <= bg[7];
            bg[5] <= bg[6];
            bg[4] <= bg[5];
            bg[3] <= bg[4];
            bg[2] <= bg[3];
            bg[1] <= bg[2];
            bg[0] <= bg[1];
        end
    end

    always @(*) begin
        if(x == 0 && bg[0][63-y] || bg[x][63-y]) begin
            en3 = 1;
            mount_data = (sel)? 16'hD581: 16'b00000_001111_01111;
        end
        else en3 = 0;
    end

endmodule
