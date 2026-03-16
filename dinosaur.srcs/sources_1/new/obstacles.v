`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 05:43:38
// Design Name: 
// Module Name: obstacles
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


module obstacles(CLOCK,over,rst,hbon,sel,scrclk,yshift,x,y,rand,en,obs_data,over_d);
    
    input CLOCK,scrclk,over,rst,hbon,sel;
    input [6:0]yshift,x,y;
    input [1:0]rand;
    output reg[15:0]obs_data;
    output reg over_d = 0, en = 0;
    
    reg [63:0]bg[95:0];
    reg [63:0]bg2[95:0];
    reg [6:0]count = 0;
    reg [1:0]obs;
    reg [63:0]hitbox;
    reg [31:0]timer = 0;
    reg [31:0]limit = 100_000_000;
    reg done = 0;
    
    wire [15:0]obs11[10:0];
    wire [15:0]obs12[10:0];
    assign obs11[0] = 16'b0000000000000000;
    assign obs11[1] = 16'b0000000011110000;
    assign obs11[2] = 16'b1000000111111000;
    assign obs11[3] = 16'b1100001111111100;
    assign obs11[4] = 16'b1111111111111110;
    assign obs11[5] = 16'b1111111111111110;
    assign obs11[6] = 16'b1000011111111110;
    assign obs11[7] = 16'b0000001111111100;
    assign obs11[8] = 16'b0000001111111000;
    assign obs11[9] = 16'b0000000111111000;
    assign obs11[10] = 16'b0000000000000000;
    assign obs12[0] = 16'b0000000011110000;
    assign obs12[1] = 16'b1000000100001000;
    assign obs12[2] = 16'b1100001000000100;
    assign obs12[3] = 16'b1111110000000010;
    assign obs12[4] = 16'b1111110000000001;
    assign obs12[5] = 16'b1111110000000001;
    assign obs12[6] = 16'b1111110000000001;
    assign obs12[7] = 16'b1000010000000010;
    assign obs12[8] = 16'b0000000000000100;
    assign obs12[9] = 16'b0000001000000000;
    assign obs12[10] = 16'b0000000111111000;
    wire [15:0]obs21[10:0];
    wire [15:0]obs22[10:0];
    assign obs21[0] = 16'b0000000000000000;
    assign obs21[1] = 16'b0000001111111100;
    assign obs21[2] = 16'b0000111111111110;
    assign obs21[3] = 16'b1111111111111110;
    assign obs21[4] = 16'b1111111111111110;
    assign obs21[5] = 16'b1111111111111110;
    assign obs21[6] = 16'b0000011111111110;
    assign obs21[7] = 16'b0000000000000000;
    assign obs21[8] = 16'b0000000000000000;
    assign obs21[9] = 16'b0000000000000000;
    assign obs21[10] = 16'b0000000000000000;
    assign obs22[0] = 16'b0000001111111110;
    assign obs22[1] = 16'b0000110000000000;
    assign obs22[2] = 16'b1111000000000001;
    assign obs22[3] = 16'b0000000000000001;
    assign obs22[4] = 16'b0000000000000001;
    assign obs22[5] = 16'b0000000000000001;
    assign obs22[6] = 16'b1111100000000001;
    assign obs22[7] = 16'b0000011111111100;
    assign obs22[8] = 16'b0000000000000000;
    assign obs22[9] = 16'b0000000000000000;
    assign obs22[10] = 16'b0000000000000000;
    wire [12:0]obs31[20:0];
    wire [12:0]obs32[20:0];
    assign obs31[0] = 13'b0000000010000;
    assign obs31[1] = 13'b0000000110000;
    assign obs31[2] = 13'b0000000110000;
    assign obs31[3] = 13'b0000001110000;
    assign obs31[4] = 13'b0000001110000;
    assign obs31[5] = 13'b0000001100000;
    assign obs31[6] = 13'b0000001100000;
    assign obs31[7] = 13'b0000001000000;
    assign obs31[8] = 13'b0000111100000;
    assign obs31[9] = 13'b0000011110000;
    assign obs31[10] = 13'b0000101000000;
    assign obs31[11] = 13'b0000100010000;
    assign obs31[12] = 13'b0011011111001;
    assign obs31[13] = 13'b0001011111110;
    assign obs31[14] = 13'b0000001111100;
    assign obs31[15] = 13'b0000001100100;
    assign obs31[16] = 13'b0000001100100;
    assign obs31[17] = 13'b0000001111000;
    assign obs31[18] = 13'b0000001111000;
    assign obs31[19] = 13'b0000001110000;
    assign obs31[20] = 13'b0000000110000;
    assign obs32[0] = 13'b0000000010000;
    assign obs32[1] = 13'b0000000110000;
    assign obs32[2] = 13'b0000000100000;
    assign obs32[3] = 13'b0000001000000;
    assign obs32[4] = 13'b0000001000000;
    assign obs32[5] = 13'b0000000000000;
    assign obs32[6] = 13'b0000000000000;
    assign obs32[7] = 13'b0000010100000;
    assign obs32[8] = 13'b0000000010000;
    assign obs32[9] = 13'b0011100000000;
    assign obs32[10] = 13'b0111010110000;
    assign obs32[11] = 13'b0110011100000;
    assign obs32[12] = 13'b0000100000001;
    assign obs32[13] = 13'b0000100000110;
    assign obs32[14] = 13'b0000100000100;
    assign obs32[15] = 13'b0000000011000;
    assign obs32[16] = 13'b0000000011000;
    assign obs32[17] = 13'b0000000100000;
    assign obs32[18] = 13'b0000001000000;
    assign obs32[19] = 13'b0000000100000;
    assign obs32[20] = 13'b0000000000000;
    
    always @(posedge CLOCK) begin
        timer = (timer == limit)? 0: timer+1;
        if(timer == 0) begin
            limit <= 50_000_000+rand*25_000_000;
            obs <= (rand)? rand: 1;
        end
        if (done) obs <= 0;
    end
    
    always @(posedge scrclk) begin
        if(~over&&~rst) begin
            done <= 0;
            if(obs == 1) begin
                if (count<11) count <= count+1;
                else if (count == 11) begin
                    done <= 1;
                    count <= 0;
                end
                if (!sel)begin
                    bg[95] <= 16'b0|obs11[count] << 40;
                    bg2[95] <= 16'b0|obs12[count]<<40;
                end
                else begin
                    bg[95] <= 16'b0|obs21[count]<<40;
                    bg2[95] <= 16'b0|obs22[count]<<40;
                end
            end
            else if(obs == 2) begin
                if (count<20) count <= count+1;
                else if (count == 20) begin
                    done <= 1;
                    count <= 0;
                end
                bg[95] <= 16'b0|obs31[20-count]<<20;
                bg2[95] <= 16'b0|obs32[20-count]<<20;
            end
            else if(obs == 3) begin
                if (count<20) count <= count+1;
                else if (count == 20) begin
                    done <= 1;
                    count <= 0;
                end
                bg[95] <= 16'b0|obs31[20-count];
                bg2[95] <= 16'b0|obs32[20-count];
            end
            else begin
                bg[95] <= 0;
                bg2[95]<= 0;
            end
            begin
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
                bg2[94] <= bg2[95];
                bg2[93] <= bg2[94];
                bg2[92] <= bg2[93];
                bg2[91] <= bg2[92];
                bg2[90] <= bg2[91];
                bg2[89] <= bg2[90];
                bg2[88] <= bg2[89];
                bg2[87] <= bg2[88];
                bg2[86] <= bg2[87];
                bg2[85] <= bg2[86];
                bg2[84] <= bg2[85];
                bg2[83] <= bg2[84];
                bg2[82] <= bg2[83];
                bg2[81] <= bg2[82];
                bg2[80] <= bg2[81];
                bg2[79] <= bg2[80];
                bg2[78] <= bg2[79];
                bg2[77] <= bg2[78];
                bg2[76] <= bg2[77];
                bg2[75] <= bg2[76];
                bg2[74] <= bg2[75];
                bg2[73] <= bg2[74];
                bg2[72] <= bg2[73];
                bg2[71] <= bg2[72];
                bg2[70] <= bg2[71];
                bg2[69] <= bg2[70];
                bg2[68] <= bg2[69];
                bg2[67] <= bg2[68];
                bg2[66] <= bg2[67];
                bg2[65] <= bg2[66];
                bg2[64] <= bg2[65];
                bg2[63] <= bg2[64];
                bg2[62] <= bg2[63];
                bg2[61] <= bg2[62];
                bg2[60] <= bg2[61];
                bg2[59] <= bg2[60];
                bg2[58] <= bg2[59];
                bg2[57] <= bg2[58];
                bg2[56] <= bg2[57];
                bg2[55] <= bg2[56];
                bg2[54] <= bg2[55];
                bg2[53] <= bg2[54];
                bg2[52] <= bg2[53];
                bg2[51] <= bg2[52];
                bg2[50] <= bg2[51];
                bg2[49] <= bg2[50];
                bg2[48] <= bg2[49];
                bg2[47] <= bg2[48];
                bg2[46] <= bg2[47];
                bg2[45] <= bg2[46];
                bg2[44] <= bg2[45];
                bg2[43] <= bg2[44];
                bg2[42] <= bg2[43];
                bg2[41] <= bg2[42];
                bg2[40] <= bg2[41];
                bg2[39] <= bg2[40];
                bg2[38] <= bg2[39];
                bg2[37] <= bg2[38];
                bg2[36] <= bg2[37];
                bg2[35] <= bg2[36];
                bg2[34] <= bg2[35];
                bg2[33] <= bg2[34];
                bg2[32] <= bg2[33];
                bg2[31] <= bg2[32];
                bg2[30] <= bg2[31];
                bg2[29] <= bg2[30];
                bg2[28] <= bg2[29];
                bg2[27] <= bg2[28];
                bg2[26] <= bg2[27];
                bg2[25] <= bg2[26];
                bg2[24] <= bg2[25];
                bg2[23] <= bg2[24];
                bg2[22] <= bg2[23];
                bg2[21] <= bg2[22];
                bg2[20] <= bg2[21];
                bg2[19] <= bg2[20];
                bg2[18] <= bg2[19];
                bg2[17] <= bg2[18];
                bg2[16] <= bg2[17];
                bg2[15] <= bg2[16];
                bg2[14] <= bg2[15];
                bg2[13] <= bg2[14];
                bg2[12] <= bg2[13];
                bg2[11] <= bg2[12];
                bg2[10] <= bg2[11];
                bg2[9] <= bg2[10];
                bg2[8] <= bg2[9];
                bg2[7] <= bg2[8];
                bg2[6] <= bg2[7];
                bg2[5] <= bg2[6];
                bg2[4] <= bg2[5];
                bg2[3] <= bg2[4];
                bg2[2] <= bg2[3];
                bg2[1] <= bg2[2];
                bg2[0] <= bg2[1];
            end
        end
        else begin
            done = 1;
            count = 0;
            bg[95] = 0;
            bg[94] = 0;
            bg[93] = 0;
            bg[92] = 0;
            bg[91] = 0;
            bg[90] = 0;
            bg[89] = 0;
            bg[88] = 0;
            bg[87] = 0;
            bg[86] = 0;
            bg[85] = 0;
            bg[84] = 0;
            bg[83] = 0;
            bg[82] = 0;
            bg[81] = 0;
            bg[80] = 0;
            bg[79] = 0;
            bg[78] = 0;
            bg[77] = 0;
            bg[76] = 0;
            bg[75] = 0;
            bg[74] = 0;
            bg[73] = 0;
            bg[72] = 0;
            bg[71] = 0;
            bg[70] = 0;
            bg[69] = 0;
            bg[68] = 0;
            bg[67] = 0;
            bg[66] = 0;
            bg[65] = 0;
            bg[64] = 0;
            bg[63] = 0;
            bg[62] = 0;
            bg[61] = 0;
            bg[60] = 0;
            bg[59] = 0;
            bg[58] = 0;
            bg[57] = 0;
            bg[56] = 0;
            bg[55] = 0;
            bg[54] = 0;
            bg[53] = 0;
            bg[52] = 0;
            bg[51] = 0;
            bg[50] = 0;
            bg[49] = 0;
            bg[48] = 0;
            bg[47] = 0;
            bg[46] = 0;
            bg[45] = 0;
            bg[44] = 0;
            bg[43] = 0;
            bg[42] = 0;
            bg[41] = 0;
            bg[40] = 0;
            bg[39] = 0;
            bg[38] = 0;
            bg[37] = 0;
            bg[36] = 0;
            bg[35] = 0;
            bg[34] = 0;
            bg[33] = 0;
            bg[32] = 0;
            bg[31] = 0;
            bg[30] = 0;
            bg[29] = 0;
            bg[28] = 0;
            bg[27] = 0;
            bg[26] = 0;
            bg[25] = 0;
            bg[24] = 0;
            bg[23] = 0;
            bg[22] = 0;
            bg[21] = 0;
            bg[20] = 0;
            bg[19] = 0;
            bg[18] = 0;
            bg[17] = 0;
            bg[16] = 0;
            bg[15] = 0;
            bg[14] = 0;
            bg[13] = 0;
            bg[12] = 0;
            bg[11] = 0;
            bg[10] = 0;
            bg[9] = 0;
            bg[8] = 0;
            bg[7] = 0;
            bg[6] = 0;
            bg[5] = 0;
            bg[4] = 0;
            bg[3] = 0;
            bg[2] = 0;
            bg[1] = 0;
            bg[0] = 0;
            bg2[95] = 0;
            bg2[94] = 0;
            bg2[93] = 0;
            bg2[92] = 0;
            bg2[91] = 0;
            bg2[90] = 0;
            bg2[89] = 0;
            bg2[88] = 0;
            bg2[87] = 0;
            bg2[86] = 0;
            bg2[85] = 0;
            bg2[84] = 0;
            bg2[83] = 0;
            bg2[82] = 0;
            bg2[81] = 0;
            bg2[80] = 0;
            bg2[79] = 0;
            bg2[78] = 0;
            bg2[77] = 0;
            bg2[76] = 0;
            bg2[75] = 0;
            bg2[74] = 0;
            bg2[73] = 0;
            bg2[72] = 0;
            bg2[71] = 0;
            bg2[70] = 0;
            bg2[69] = 0;
            bg2[68] = 0;
            bg2[67] = 0;
            bg2[66] = 0;
            bg2[65] = 0;
            bg2[64] = 0;
            bg2[63] = 0;
            bg2[62] = 0;
            bg2[61] = 0;
            bg2[60] = 0;
            bg2[59] = 0;
            bg2[58] = 0;
            bg2[57] = 0;
            bg2[56] = 0;
            bg2[55] = 0;
            bg2[54] = 0;
            bg2[53] = 0;
            bg2[52] = 0;
            bg2[51] = 0;
            bg2[50] = 0;
            bg2[49] = 0;
            bg2[48] = 0;
            bg2[47] = 0;
            bg2[46] = 0;
            bg2[45] = 0;
            bg2[44] = 0;
            bg2[43] = 0;
            bg2[42] = 0;
            bg2[41] = 0;
            bg2[40] = 0;
            bg2[39] = 0;
            bg2[38] = 0;
            bg2[37] = 0;
            bg2[36] = 0;
            bg2[35] = 0;
            bg2[34] = 0;
            bg2[33] = 0;
            bg2[32] = 0;
            bg2[31] = 0;
            bg2[30] = 0;
            bg2[29] = 0;
            bg2[28] = 0;
            bg2[27] = 0;
            bg2[26] = 0;
            bg2[25] = 0;
            bg2[24] = 0;
            bg2[23] = 0;
            bg2[22] = 0;
            bg2[21] = 0;
            bg2[20] = 0;
            bg2[19] = 0;
            bg2[18] = 0;
            bg2[17] = 0;
            bg2[16] = 0;
            bg2[15] = 0;
            bg2[14] = 0;
            bg2[13] = 0;
            bg2[12] = 0;
            bg2[11] = 0;
            bg2[10] = 0;
            bg2[9] = 0;
            bg2[8] = 0;
            bg2[7] = 0;
            bg2[6] = 0;
            bg2[5] = 0;
            bg2[4] = 0;
            bg2[3] = 0;
            bg2[2] = 0;
            bg2[1] = 0;
            bg2[0] = 0;
        end
    end
    
    always @(*) begin
        hitbox = 31<<yshift+5;
        if (bg[x][y] && !bg2[x][y]) begin
            en = 1;
            obs_data = 16'h3E88;
        end
        else if (!bg[x][y] && bg2[x][y]) begin
            en = 1;
            obs_data = 16'h0000;
        end
        else if (bg[x][y] && bg2[x][y]) begin
            en = 1;
            obs_data = 16'hD581;
        end
        else en = 0;
        if((hitbox&(bg[25]|bg[24]|bg[23]|bg[22]|bg[21]|bg[20]|bg[19]|bg[18]|bg2[25]|bg2[24]|bg2[23]|bg2[22]|bg2[21]|bg2[20]|bg2[19]|bg2[18]))&&hbon) over_d = 1;
        else over_d = 0;
    end
    
endmodule
