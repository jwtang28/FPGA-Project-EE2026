`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2023 14:15:51
// Design Name: 
// Module Name: scrolling_game_over_message
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


module scrolling_game_over_message(input CLOCK, [6:0]an0, [6:0]an1, [6:0]an2, [6:0]an3, output [15:0]led, reg [6:0]seg, reg [3:0]an, input condition);
    
    reg [15:0] LED = 16'b1111111111111111;
    reg [6:0] AN [3:0];
    reg [4:0] scroll = 0;
    reg [1:0] count = 0;
    reg [4:0] ledcounter = 16;
    wire [6:0] message [28:0];
    wire clk_4hz, clk_2p666hz, clk_1khz;
    
    clk_divider clk_4_ko(CLOCK, 12_499_999, clk_4hz);  //Scrolling Message
    clk_divider clk_2p666_ko(CLOCK, 18_749_999, clk_2p666hz);  //LED
    clk_divider clk_1k_ko(CLOCK, 49_999, clk_1khz);  //7-Segment
    
    assign led = LED;
    
    assign message[0] = 7'b1111111;  //space
    assign message[1] = 7'b1111111;  //space
    assign message[2] = 7'b1111111;  //space
    assign message[3] = 7'b1111111;  //space
    assign message[4] = 7'b1000010;  //G
    assign message[5] = 7'b0001000;  //A
    assign message[6] = 7'b0101010;  //M
    assign message[7] = 7'b0000110;  //E
    assign message[8] = 7'b1111111;  //space
    assign message[9] = 7'b1000000;  //O
    assign message[10] = 7'b1010101;  //V
    assign message[11] = 7'b0000110;  //E
    assign message[12] = 7'b1001100;  //R
    assign message[13] = 7'b1111111;  //space
    assign message[14] = 7'b0111101;  //left eye
    assign message[15] = 7'b0101011;  //sad mouth
    assign message[16] = 7'b0011111;  //right eye
    assign message[17] = 7'b1111111;  //space
    assign message[18] = 7'b1111111;  //space
    assign message[19] = 7'b0010010;  //S
    assign message[20] = 7'b1000110;  //C
    assign message[21] = 7'b1000000;  //O
    assign message[22] = 7'b1001100;  //R
    assign message[23] = 7'b0000110;  //E
    assign message[24] = 7'b1111111;  //space
    assign message[28] = an0;
    assign message[27] = an1;
    assign message[26] = an2;
    assign message[25] = an3;
    
    always @(posedge clk_4hz) begin
        if (condition) begin
            //Scrolling Message (No Looping)
            if (scroll < 25) scroll <= scroll + 1;
            AN[3] = message[scroll];
            AN[2] = message[scroll + 1];
            AN[1] = message[scroll + 2];
            AN[0] = message[scroll + 3];        
        end
        else begin
            scroll <= 0;
            AN[3] = 7'b1111111;
            AN[2] = 7'b1111111;
            AN[1] = 7'b1111111;
            AN[0] = 7'b1111111;
        end   
    end
    
    always @(posedge clk_2p666hz) begin
        if (condition) begin
            //LED
            if (ledcounter > 0) ledcounter <= ledcounter - 1;
            LED[ledcounter] = 0;
        end
        else begin
            ledcounter <= 16;
            LED = 16'b1111111111111111;
        end
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