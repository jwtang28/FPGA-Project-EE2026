`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 23:31:46
// Design Name: 
// Module Name: grass
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


module grass(scrclk, over, x, y, rand, en2, grass_data,sel);
    
    input scrclk,over,sel;
    input [1:0]rand;
    input [6:0]x, y;
    output reg en2;
    output reg [15:0] grass_data;
    
    reg [63:0]grass[95:0];
    reg [63:0]line = 1023;
    
    always @(posedge scrclk) begin
        if(~over) begin
            grass[95] <= line>>rand;
            grass[94] <= grass[95];
            grass[93] <= grass[94];
            grass[92] <= grass[93];
            grass[91] <= grass[92];
            grass[90] <= grass[91];
            grass[89] <= grass[90];
            grass[88] <= grass[89];
            grass[87] <= grass[88];
            grass[86] <= grass[87];
            grass[85] <= grass[86];
            grass[84] <= grass[85];
            grass[83] <= grass[84];
            grass[82] <= grass[83];
            grass[81] <= grass[82];
            grass[80] <= grass[81];
            grass[79] <= grass[80];
            grass[78] <= grass[79];
            grass[77] <= grass[78];
            grass[76] <= grass[77];
            grass[75] <= grass[76];
            grass[74] <= grass[75];
            grass[73] <= grass[74];
            grass[72] <= grass[73];
            grass[71] <= grass[72];
            grass[70] <= grass[71];
            grass[69] <= grass[70];
            grass[68] <= grass[69];
            grass[67] <= grass[68];
            grass[66] <= grass[67];
            grass[65] <= grass[66];
            grass[64] <= grass[65];
            grass[63] <= grass[64];
            grass[62] <= grass[63];
            grass[61] <= grass[62];
            grass[60] <= grass[61];
            grass[59] <= grass[60];
            grass[58] <= grass[59];
            grass[57] <= grass[58];
            grass[56] <= grass[57];
            grass[55] <= grass[56];
            grass[54] <= grass[55];
            grass[53] <= grass[54];
            grass[52] <= grass[53];
            grass[51] <= grass[52];
            grass[50] <= grass[51];
            grass[49] <= grass[50];
            grass[48] <= grass[49];
            grass[47] <= grass[48];
            grass[46] <= grass[47];
            grass[45] <= grass[46];
            grass[44] <= grass[45];
            grass[43] <= grass[44];
            grass[42] <= grass[43];
            grass[41] <= grass[42];
            grass[40] <= grass[41];
            grass[39] <= grass[40];
            grass[38] <= grass[39];
            grass[37] <= grass[38];
            grass[36] <= grass[37];
            grass[35] <= grass[36];
            grass[34] <= grass[35];
            grass[33] <= grass[34];
            grass[32] <= grass[33];
            grass[31] <= grass[32];
            grass[30] <= grass[31];
            grass[29] <= grass[30];
            grass[28] <= grass[29];
            grass[27] <= grass[28];
            grass[26] <= grass[27];
            grass[25] <= grass[26];
            grass[24] <= grass[25];
            grass[23] <= grass[24];
            grass[22] <= grass[23];
            grass[21] <= grass[22];
            grass[20] <= grass[21];
            grass[19] <= grass[20];
            grass[18] <= grass[19];
            grass[17] <= grass[18];
            grass[16] <= grass[17];
            grass[15] <= grass[16];
            grass[14] <= grass[15];
            grass[13] <= grass[14];
            grass[12] <= grass[13];
            grass[11] <= grass[12];
            grass[10] <= grass[11];
            grass[9] <= grass[10];
            grass[8] <= grass[9];
            grass[7] <= grass[8];
            grass[6] <= grass[7];
            grass[5] <= grass[6];
            grass[4] <= grass[5];
            grass[3] <= grass[4];
            grass[2] <= grass[3];
            grass[1] <= grass[2];
            grass[0] <= grass[1];
        end
    end
    
    always @(*) begin
        if(sel) begin
            if (y>56) begin
                en2 = 1;
                grass_data = 16'hD581;
            end
            else if (y>53) begin
                en2 = 1;
                grass_data = 16'hFFE0;
            end
            else if (y>52) begin
                en2 = 1;
                grass_data = 0;
            end
            else en2 = 0;
        end
        else begin
            if (x == 0 && grass[0][63-y] || grass[x][63-y]) begin
                en2 = 1;
                grass_data = 16'b00000_011111_00000;       //dark green grass
            end
            else if (grass[x][61-y]) begin
                en2 = 1;
                grass_data = 16'b00000_111111_00000;                             //green grass
            end
            else if (grass[x][60-y]) begin
                en2 = 1;
                grass_data = 16'b00000_001111_00000;
            end
            else if (grass[x][59-y]) begin
                en2 = 1;
                grass_data = 0;                                                  //black outline
            end
            else en2 = 0;
        end
    end
endmodule
