`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2023 00:37:54
// Design Name: 
// Module Name: scrolling_chara_select_message
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


module scrolling_chara_select_message(input CLOCK, output reg [15:0]led, reg [6:0]seg, reg [3:0]an, input condition);
    
    reg [6:0] AN [3:0];
    reg [4:0] scroll = 0;
    reg [1:0] count = 0;
    wire [6:0] message [23:0];
    wire clk_4hz, clk_5hz, clk_1khz;
    
    clk_divider clk_4_chara_select(CLOCK, 12_499_999, clk_4hz);  //Scrolling Message
    clk_divider clk_5_chara_select(CLOCK, 9_999_999, clk_5hz);  //LED 2.5hz Blink
    clk_divider clk_1k_chara_select(CLOCK, 49_999, clk_1khz);  //7-Segment
    
    assign message[0] = 7'b1111111;  //space
    assign message[1] = 7'b1111111;  //space
    assign message[2] = 7'b1111111;  //space
    assign message[3] = 7'b1111111;  //space
    assign message[4] = 7'b1000110;  //C
    assign message[5] = 7'b0001001;  //H
    assign message[6] = 7'b1000000;  //O
    assign message[7] = 7'b1000000;  //O
    assign message[8] = 7'b0010010;  //S
    assign message[9] = 7'b0000110;  //E
    assign message[10] = 7'b1111111;  //space
    assign message[11] = 7'b0010001;  //Y
    assign message[12] = 7'b1000000;  //O
    assign message[13] = 7'b1000001;  //U
    assign message[14] = 7'b1001100;  //R
    assign message[15] = 7'b1111111;  //space
    assign message[16] = 7'b0100001;  //D
    assign message[17] = 7'b1111001;  //I
    assign message[18] = 7'b1000000;  //O
    assign message[19] = 7'b0010010;  //S
    assign message[20] = 7'b0001000;  //A
    assign message[21] = 7'b1000001;  //U
    assign message[22] = 7'b1001100;  //R
    assign message[23] = 7'b1111111;  //space
    
    always @(posedge clk_4hz) begin
        if (condition) begin
            scroll <= (scroll == 23) ? 0 : scroll + 1;
            AN[3] = message[scroll];
            AN[2] = message[(scroll == 23) ? 0 : scroll + 1];
            AN[1] = message[(scroll >= 22) ? scroll - 22 : scroll + 2];
            AN[0] = message[(scroll >= 21) ? scroll - 21 : scroll + 3];
        end
        else scroll = 0;
    end
    
    always @(posedge clk_5hz) begin
        led = ~led;
    end
    
    always @(posedge clk_1khz) begin
        count <= count + 1;
        case(count)
            2'b00: begin
                seg = AN[0];
                an = 4'b1110;
            end
            2'b01: begin
                seg = AN[1];
                an = 4'b1101;
            end
            2'b10: begin
                seg = AN[2];
                an = 4'b1011;
            end
            2'b11: begin
                seg = AN[3];
                an = 4'b0111;
            end
        endcase
    end
    
endmodule