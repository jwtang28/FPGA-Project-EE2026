`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 09:50:24
// Design Name: 
// Module Name: oled
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


module oled(CLOCK, btnC, btnD, btnU, PS2Clk, PS2Data, JB, over, an0, an1, an2, an3, led, seg, an,sel,character);
    
    input CLOCK;
    input btnC;
    input btnD;
    input btnU;
    inout PS2Clk;
    inout PS2Data;
    output [7:0]JB;
    output reg over = 0;
    output [6:0]an0,an1,an2,an3;
    output reg [15:0]led;
    output reg [6:0]seg;
    output reg [3:0]an;
    reg [31:0]score = 0;
    input sel,character;
    
    //shift
    wire [127:0] shift;
    lfsr bitstream(CLOCK, shift);
    
    //Mouse
    wire [11:0] xpos;
    wire [11:0] ypos; 
    wire [3:0] zpos;
    wire left, right, middle, new_event;
    reg rst = 0;
    MouseCtl m(.clk(CLOCK),.rst(rst),.xpos(xpos),.ypos(ypos),.zpos(zpos),.left(left),.middle(middle),.right(right),
               .new_event(new_event),.value(0),.setx(0),.sety(0),.setmax_x(0),.setmax_y(0),.ps2_clk(PS2Clk),.ps2_data(PS2Data));
    
    //reset
    wire btnd;
    assign btnd = btnD|middle;
    
    //oled
    wire clk, reset, frame_begin, sending_pixels,
          sample_pixel, cs, sdin, sclk, d_cn, resn, vccen,
          pmoden;
    wire [12:0]pixel_index;
    reg [15:0]pixel_data = 31;
    assign reset = 0;
    assign JB[1:0] = {sdin, cs};
    assign JB[7:3] = {pmoden, vccen, resn, d_cn, sclk};
    clk_divider oledclk(CLOCK,7,clk); 
    Oled_Display(clk, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, pixel_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden);
    
    //x y
    wire [12:0]x, y;
    coor coordinates(pixel_index, x, y);
    
    //platform
    wire scrclk;
    wire en2;
    wire [15:0] grass_data;
    reg [31:0]frequency = 1000000;
    reg [31:0]count = 0;
    clk_freq_divider scrollclk(CLOCK, frequency, scrclk);
    grass plstouchsomegrass(scrclk, over, x, y, shift[1:0], en2, grass_data, sel);
    always @(posedge scrclk) begin
        if(over||btnd) count = 299;
        else count <= count + 1;
        if (count == 300) frequency = 60;
        if (count%100==0) frequency = frequency + 3;
    end
    
    //mount
    wire bgclk, en3;
    wire [15:0]mount_data;
    clk_freq_divider mtclk(CLOCK, frequency/3, bgclk);
    mount mountain(bgclk, over, x, y, shift[2:0], en3, mount_data, sel);

    //cloud
    wire cldclk, en4;
    wire [15:0]cloud_data;
    clk_freq_divider cloudclk(CLOCK, frequency/4, cldclk);
    cloud clouds(cldclk, over, x, y, en4, cloud_data);
    
    //char
    wire en1;
    wire [15:0]char_data;
    reg [6:0]xshift = 5, yshift = 40;
    reg [31:0]timer = 0;
    reg jump = 0;
    reg fly = 0;
    reg flying = 0;
    char dinosaur(CLOCK, jump, fly, flying, x, y, xshift, yshift, en1, char_data, character);
    
    //score
    reg [6:0]AN[3:0];
    wire clk30,clk1000;
    reg [4:0]powcount = 0;
    reg [1:0]ancount = 0;
    reg toggle = 0;
    clk_freq_divider scoreclk(CLOCK, 30, clk30);
    always @(posedge clk30)begin
        if(~over)score <= score + 1;
        if (powcount == 0) led = 0;
        if (score%24==0&&powcount<16) begin 
            powcount <= powcount + 1;
            led <= 16'hFFFF>>(16-powcount);
        end
        else if(powcount == 16) begin
            if(score%2==0)toggle <= ~toggle;
            led <= (toggle)? 0: 16'hFFFF;
        end
        if(btnd) score <= 0; 
        if(btnd||fly) powcount <= 0;
    end
    clk_freq_divider anclk(CLOCK, 1000, clk1000);
    always @(posedge clk1000) begin
        case(score%10)
            0: AN[0] = 7'b1000000;
            1: AN[0] = 7'b1111001;
            2: AN[0] = 7'b0100100;
            3: AN[0] = 7'b0110000;
            4: AN[0] = 7'b0011001;
            5: AN[0] = 7'b0010010;
            6: AN[0] = 7'b0000010;
            7: AN[0] = 7'b1111000;
            8: AN[0] = 7'b0000000;
            default: AN[0] = 7'b0010000;
        endcase
        case((score%100)/10)
            0: AN[1] = 7'b1000000;
            1: AN[1] = 7'b1111001;
            2: AN[1] = 7'b0100100;
            3: AN[1] = 7'b0110000;
            4: AN[1] = 7'b0011001;
            5: AN[1] = 7'b0010010;
            6: AN[1] = 7'b0000010;
            7: AN[1] = 7'b1111000;
            8: AN[1] = 7'b0000000;
            default: AN[1] = 7'b0010000;
        endcase
        case((score%1000)/100)
            0: AN[2] = 7'b1000000;
            1: AN[2] = 7'b1111001;
            2: AN[2] = 7'b0100100;
            3: AN[2] = 7'b0110000;
            4: AN[2] = 7'b0011001;
            5: AN[2] = 7'b0010010;
            6: AN[2] = 7'b0000010;
            7: AN[2] = 7'b1111000;
            8: AN[2] = 7'b0000000;
            default: AN[2] = 7'b0010000;
        endcase
        case(score/1000)
            0: AN[3] = 7'b1000000;
            1: AN[3] = 7'b1111001;
            2: AN[3] = 7'b0100100;
            3: AN[3] = 7'b0110000;
            4: AN[3] = 7'b0011001;
            5: AN[3] = 7'b0010010;
            6: AN[3] = 7'b0000010;
            7: AN[3] = 7'b1111000;
            8: AN[3] = 7'b0000000;
            default: AN[3] = 7'b0010000;
        endcase
    
        ancount <= ancount + 1;
        case(ancount)
            0: begin
                seg = AN[0];
                an = 4'b1110;
            end
            1: begin
                seg = AN[1];
                an = 4'b1101;
            end
            2: begin   
                seg = AN[2];
                an = 4'b1011;
            end
            default: begin
                seg = AN[3];
                an = 4'b0111;
            end
        endcase
    end
    
    assign an0 = AN[0];
    assign an1 = AN[1];
    assign an2 = AN[2];
    assign an3 = AN[3];
    
    //gameplay    
    //jump
    wire btnc;
    assign btnc = btnC|left;    
    reg [5:0]multiplier = 1;    
    reg dir = 1;
    //fly
    wire btnu;
    assign btnu = (powcount == 16)? btnU|right:0;
    reg [31:0]timer2 = 0;
    reg [31:0]timer3 = 0;
    //obstacle
    wire en6, over_d;
    wire [15:0]obs_data;
    reg hbon = 1;
    reg [31:0]timer4 = 0;
    obstacles whyarewestillhere(CLOCK,over,btnd,hbon,sel,scrclk,yshift,x,y,shift[1:0],en6,obs_data,over_d);
    
    always @(posedge CLOCK) begin
        if (~over) begin
            //jump
            if (btnc || (jump&&!fly)) begin
                jump = 1;
                timer = timer + 1;
                if (yshift == 10||yshift <= ypos) dir = 0;
                if (yshift == 40) begin
                    dir = 1;
                    jump = 0;
                end
                if (timer == 55_000*multiplier) begin
                    timer = 0;
                    multiplier = 41-yshift;
                    yshift = (dir)? yshift - 1: yshift+1;
                end
            end
            else begin
                dir = 1;
                jump = 0;
            end
            //fly
            if (btnu) fly = 1;
            if (fly) begin
                timer3 = (timer3 == 2_000_000)? 0: timer3+1;
                if (timer2 < 800_000_000) timer2 = timer2 + 1;
                if (timer2 < 750_000_000) flying = 1;
                else flying = 0;
                if (timer2 == 800_000_000 && timer3==0 && yshift<40) yshift = yshift + 1;
                else if(timer3==0 && yshift > ypos) yshift = yshift - 1;
                else if(timer3==0 && yshift < ypos) yshift = yshift + 1;
                if (yshift == 40 && timer2 > 10_000_000) begin
                    fly = 0;
                    timer2 = 0;
                    timer3 = 0;
                    flying = 0;
                end
            end
            //obstacle
            over = over_d;
        end
        if (over) begin
            timer4 = (timer4 == 1_000_000)? 0: timer4+1;
            if (timer4 == 0 && yshift<60) yshift = yshift +1;
        end
        
        //reset
        if(btnd) begin
            xshift = 5;
            yshift = 40;
            timer = 0;
            timer2 = 0;
            timer3 = 0;
            jump = 0;
            multiplier = 1;
            dir = 1;
            fly = 0;
            over = 0;
            hbon=1;
            timer4 = 0;
            flying = 0;
        end
    end    
    
    //display
    always @(posedge clk) begin
        if (x == xpos && y == ypos)pixel_data = 0;
        else if((x == xpos-1 && y == ypos)||(x == xpos+1 && y == ypos)||(x == xpos && y == ypos-1)||(x == xpos && y == ypos+1)) pixel_data = 16'b11111_111111_11111;
        else if (en2) pixel_data = grass_data;                                                
        else if (en1&&xshift<=x&&x<=20+xshift&&yshift<=y&&y<=12+yshift) pixel_data = char_data;    
        else if (en6) pixel_data = obs_data;
        else if (en3) pixel_data = mount_data;
        else if (en4&&y<22) pixel_data = cloud_data;
        else pixel_data = 16'b00111_000111_11111;
    end
    
endmodule
