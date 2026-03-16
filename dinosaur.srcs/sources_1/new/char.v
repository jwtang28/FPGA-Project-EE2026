`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 14:20:28
// Design Name: 
// Module Name: char
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


module char(CLOCK,btn,fly,flying,x,y,xshift,yshift,en,col_index, character);

    input CLOCK,btn,fly,character,flying;
    input [6:0]x,y,xshift,yshift;
    output reg en = 1;
    output reg [15:0] col_index;
    
    wire clk;
    clk_freq_divider(CLOCK,2,clk);
    
    wire [12:0]jump1[20:0];
    wire [12:0]jump2[20:0];
    assign jump1[0] = 13'b0000000010000;
    assign jump1[1] = 13'b0000000110000;
    assign jump1[2] = 13'b0000000110000;
    assign jump1[3] = 13'b0000001110000;
    assign jump1[4] = 13'b0000001110000;
    assign jump1[5] = 13'b0000001100000;
    assign jump1[6] = 13'b0000001100000;
    assign jump1[7] = 13'b0000001000000;
    assign jump1[8] = 13'b0000111100000;
    assign jump1[9] = 13'b0000011110000;
    assign jump1[10] = 13'b0000101000000;
    assign jump1[11] = 13'b0000100010000;
    assign jump1[12] = 13'b0011011111001;
    assign jump1[13] = 13'b0001011111110;
    assign jump1[14] = 13'b0000001111100;
    assign jump1[15] = 13'b0000001100100;
    assign jump1[16] = 13'b0000001100100;
    assign jump1[17] = 13'b0000001111000;
    assign jump1[18] = 13'b0000001111000;
    assign jump1[19] = 13'b0000001110000;
    assign jump1[20] = 13'b0000000110000;
    assign jump2[0] = 13'b0000000010000;
    assign jump2[1] = 13'b0000000110000;
    assign jump2[2] = 13'b0000000100000;
    assign jump2[3] = 13'b0000001000000;
    assign jump2[4] = 13'b0000001000000;
    assign jump2[5] = 13'b0000000000000;
    assign jump2[6] = 13'b0000000000000;
    assign jump2[7] = 13'b0000010100000;
    assign jump2[8] = 13'b0000000010000;
    assign jump2[9] = 13'b0011100000000;
    assign jump2[10] = 13'b0111010110000;
    assign jump2[11] = 13'b0110011100000;
    assign jump2[12] = 13'b0000100000001;
    assign jump2[13] = 13'b0000100000110;
    assign jump2[14] = 13'b0000100000100;
    assign jump2[15] = 13'b0000000011000;
    assign jump2[16] = 13'b0000000011000;
    assign jump2[17] = 13'b0000000100000;
    assign jump2[18] = 13'b0000001000000;
    assign jump2[19] = 13'b0000000100000;
    assign jump2[20] = 13'b0000000000000;
    
    wire [12:0]idle1[20:0];
    wire [12:0]idle2[20:0];
    assign idle1[0] = 13'b0000000010000;
    assign idle1[1] = 13'b0000000110000;
    assign idle1[2] = 13'b0000000110000;
    assign idle1[3] = 13'b0000001110000;
    assign idle1[4] = 13'b0000001110000;
    assign idle1[5] = 13'b0000011100000;
    assign idle1[6] = 13'b0010011100000;
    assign idle1[7] = 13'b0010011000000;
    assign idle1[8] = 13'b1000111100000;
    assign idle1[9] = 13'b1101011110000;
    assign idle1[10] = 13'b1001111000000;
    assign idle1[11] = 13'b0000110010000;
    assign idle1[12] = 13'b0000111111001;
    assign idle1[13] = 13'b0001111111110;
    assign idle1[14] = 13'b0000011111100;
    assign idle1[15] = 13'b0000011100100;
    assign idle1[16] = 13'b0000011100100;
    assign idle1[17] = 13'b0000011111000;
    assign idle1[18] = 13'b0000011111000;
    assign idle1[19] = 13'b0000001110000;
    assign idle1[20] = 13'b0000000110000;
    assign idle2[0] = 13'b0000000010000;
    assign idle2[1] = 13'b0000000110000;
    assign idle2[2] = 13'b0000000100000;
    assign idle2[3] = 13'b0000001000000;
    assign idle2[4] = 13'b0000001000000;
    assign idle2[5] = 13'b0000100000000;
    assign idle2[6] = 13'b1100100000000;
    assign idle2[7] = 13'b1101100100000;
    assign idle2[8] = 13'b0101000010000;
    assign idle2[9] = 13'b0000100000000;
    assign idle2[10] = 13'b0100000110000;
    assign idle2[11] = 13'b1000001100000;
    assign idle2[12] = 13'b0000000000001;
    assign idle2[13] = 13'b0000000000110;
    assign idle2[14] = 13'b0010000000100;
    assign idle2[15] = 13'b0000000011000;
    assign idle2[16] = 13'b0000000011000;
    assign idle2[17] = 13'b0000000100000;
    assign idle2[18] = 13'b0000001000000;
    assign idle2[19] = 13'b0000000100000;
    assign idle2[20] = 13'b0000000000000;
    
    wire [12:0]run1[20:0];
    wire [12:0]run2[20:0];
    assign run1[0] = 13'b0000000100000;
    assign run1[1] = 13'b0000001100000;
    assign run1[2] = 13'b0000001100000;
    assign run1[3] = 13'b0000011100000;
    assign run1[4] = 13'b0000011100000;
    assign run1[5] = 13'b1010011000000;
    assign run1[6] = 13'b0010011000000;
    assign run1[7] = 13'b0000110000000;
    assign run1[8] = 13'b1011011000000;
    assign run1[9] = 13'b1111111100000;
    assign run1[10] = 13'b1000110000000;
    assign run1[11] = 13'b0000100100000;
    assign run1[12] = 13'b0001111110010;
    assign run1[13] = 13'b0000011111100;
    assign run1[14] = 13'b0000011111000;
    assign run1[15] = 13'b0000011001000;
    assign run1[16] = 13'b0000111001000;
    assign run1[17] = 13'b0000111110000;
    assign run1[18] = 13'b0000011110000;
    assign run1[19] = 13'b0000011100000;
    assign run1[20] = 13'b0000001100000;
    assign run2[0] = 13'b0000000100000;
    assign run2[1] = 13'b0000001100000;
    assign run2[2] = 13'b0000001000000;
    assign run2[3] = 13'b0000010000000;
    assign run2[4] = 13'b1110110000000;
    assign run2[5] = 13'b0100100000000;
    assign run2[6] = 13'b0101100000000;
    assign run2[7] = 13'b1111001000000;
    assign run2[8] = 13'b0100100100000;
    assign run2[9] = 13'b0000000000000;
    assign run2[10] = 13'b0000001100000;
    assign run2[11] = 13'b0100011000000;
    assign run2[12] = 13'b1000000000010;
    assign run2[13] = 13'b0001000001100;
    assign run2[14] = 13'b0000000001000;
    assign run2[15] = 13'b0000000110000;
    assign run2[16] = 13'b0000000110000;
    assign run2[17] = 13'b0000001000000;
    assign run2[18] = 13'b0000010000000;
    assign run2[19] = 13'b0000001000000;
    assign run2[20] = 13'b0000000000000;
    
    always @(*)begin
        if (btn||fly) begin
            if (jump1[x-xshift][y-yshift] && !jump2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (flying)? 16'hFFED:(character)? 16'h07FF:16'hF800;
            end
            else if (!jump1[x-xshift][y-yshift] && jump2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = 16'h0000;
            end
            else if (jump1[x-xshift][y-yshift] && jump2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (character)?16'hC85E:16'hFFE0;
            end
            else en = 0;
        end
        else if (clk) begin
            if (idle1[x-xshift][y-yshift] && !idle2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (character)? 16'h07FF:16'hF800;
            end
            else if (!idle1[x-xshift][y-yshift] && idle2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = 16'h0000;
            end
            else if (idle1[x-xshift][y-yshift] && idle2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (character)?16'hC85E:16'hFFE0;
            end
            else en = 0;
        end
        else begin
            if (run1[x-xshift][y-yshift] && !run2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (character)? 16'h07FF:16'hF800;
            end
            else if (!run1[x-xshift][y-yshift] && run2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = 16'h0000;
            end
            else if (run1[x-xshift][y-yshift] && run2[x-xshift][y-yshift]) begin
                en = 1;
                col_index = (character)?16'hC85E:'hFFE0;
            end
            else en = 0;
        end
    end
    
endmodule
