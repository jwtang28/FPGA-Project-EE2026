`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 17:37:49
// Design Name: 
// Module Name: gametop
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


module gametop(
    input [2:0]sw,
    input CLOCK,
    input btnL,
    input btnR,
    input btnC,
    input btnD,
    input btnU,
    inout PS2Clk,
    inout PS2Data,
    output reg[7:0]JB,
    output reg[6:0]seg,
    output reg[3:0]an,
    output reg[15:0]led
    );
    
    reg[3:0]page = 3;
    
    //gameplay out
    wire [7:0]JB1;
    wire over;
    reg i1btnC = 0,i1btnD = 0,i1btnU = 0;
    
    wire [15:0]o1led;
    wire [6:0]o1seg;
    wire [3:0]o1an;
    wire [6:0] an0,an1, an2, an3;
    
    wire [15:0]o2led;
    wire [6:0]o2seg;
    wire [3:0]o2an;
    wire [7:0]JB2;
    
    wire [15:0]o3led;
    wire [6:0]o3seg;
    wire [3:0]o3an;
    
    reg i2btnR = 0;
    reg i2btnL = 0;
    wire [7:0]JB3;
    wire character;
    
    reg i3btnR=0;
    reg i3btnL=0;
    wire [7:0]JB4;
    wire sel;
    
    wire [15:0]o4led;
    wire [6:0]o4seg;
    wire [3:0]o4an;
    
    wire [15:0]o5led;
    wire [6:0]o5seg;
    wire [3:0]o5an;
    
    reg condover = 0, condworld = 0, condchar = 0, condwelc = 0;
    
    reg startup = 0,btncp = 0;
    reg order = 0;
    
    scrolling_welcome_message hello(CLOCK, o2led, o2seg, o2an, JB2, condwelc);
    
    oled gameplay(CLOCK, i1btnC, i1btnD, i1btnU, PS2Clk, PS2Data, JB1, over, an0, an1, an2, an3, o1led, o1seg, o1an, sel, character);

    scrolling_game_over_message(CLOCK, an0, an1, an2, an3, o3led, o3seg, o3an, condover);
    
    chara_select_border ( CLOCK, i2btnR, i2btnL, JB3, character);
    
    world_select_border( CLOCK, i3btnR, i3btnL, JB4, sel);
    
    scrolling_world_select_message( CLOCK, o4led, o4seg, o4an, condworld);
    
    scrolling_chara_select_message( CLOCK, o5led, o5seg, o5an, condchar);
    
    always @(posedge CLOCK) begin
        if (page == 0) startup <= 1;
        else if (startup) begin
            if (btnC && !btncp)begin
                if (order == 1) startup <= 0;
                else order <= 1;
                btncp <= 1;
            end
            else if (!btnC && btncp) btncp <= 0;
            else btncp <= btncp;
        end
        else order <= 0;
        
    end
    
    always @(*) begin
        if (sw[2]) page = 2;
        else if (sw[1]) page = 1;
        else if (sw[0]) begin
            if (startup && order == 0) page = 1;
            else if (startup && order == 1) page = 2;
            else page = 3;
        end
        else page = 0;
        case(page)
            0: begin
                i1btnC = 0;
                i1btnD = 1;
                i1btnU = 0;
                i2btnR = 0;
                i2btnL = 0;
                i3btnR = 0;
                i3btnL = 0;
                JB = JB2;
                led = o2led;
                seg = o2seg;
                an = o2an;
                condwelc = 1;
                condover = 0;
                condchar = 0;
                condworld = 0;
            end
            1: begin
                i1btnC = 0;
                i1btnD = 1;
                i1btnU = 0;
                i2btnR = btnR;
                i2btnL = btnL;
                i3btnR = 0;
                i3btnL = 0;
                JB = JB3;
                led = o5led;
                seg = o5seg;
                an = o5an;
                condover = 0;
                condchar = 1;
                condworld = 0;
                condwelc = 0;
            end
            2: begin
                i1btnC = 0;
                i1btnD = 1;
                i1btnU = 0;
                i2btnR = 0;
                i2btnL = 0;
                i3btnR = btnR;
                i3btnL = btnL;
                JB = JB4;
                led = o4led;
                seg = o4seg;
                an = o4an;
                condworld = 1;
                condover = 0;
                condchar = 0;
                condwelc = 0;
            end
            3: begin
                i1btnC = btnC;
                i1btnD = btnD;
                i1btnU = btnU;
                i2btnR = 0;
                i2btnL = 0;
                i3btnR = 0;
                i3btnL = 0;
                JB = JB1;
                condworld = 0;
                condchar = 0;
                condwelc = 0;
                if (over) begin
                    condover = 1;
                    led = o3led;
                    seg = o3seg;
                    an = o3an;
                end
                else begin
                    condover = 0;
                    led = o1led;
                    seg = o1seg;
                    an = o1an;
                end
            end
        endcase
    end
endmodule
