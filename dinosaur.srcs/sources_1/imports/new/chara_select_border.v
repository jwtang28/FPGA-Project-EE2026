`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 07:47:29
// Design Name: 
// Module Name: world_select_border
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


module chara_select_border(input CLOCK, btnR, btnL, output [7:0]JB, reg character = 0);
    
    //Coordinates
    wire [12:0] pixel_index, x, y;
    coor xy(pixel_index, x, y);
    
    //Oled Display
    reg [15:0] oled_data = 16'h0E70;
    wire [15:0] pixel_data;
    wire clk, reset, frame_begin, sending_pixels, sample_pixel, cs, sdin, sclk, d_cn, resn, vccen, pmoden;
    assign JB[1:0] = {sdin, cs};
    assign JB[7:3] = {pmoden, vccen, resn, d_cn, sclk};
    assign pixel_data = oled_data;
    assign reset = 0;
    Oled_Display oled(clk, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, pixel_data, cs, sdin, sclk, d_cn, resn, vccen, pmoden);
    clk_divider oled_clk(CLOCK, 7, clk);  //OLED 6.25MHz Clock
    
    reg lagr = 0;
    reg lagl = 0; 
    reg [6:0]sx_chara = 15; 
    reg border_chara = 0;
    
    always @(posedge clk) begin
            if (((btnR||btnL) != border_chara) && (sx_chara<=x&&x<=30+sx_chara) && (17<=y&&y<=44) && !((2+sx_chara<=x&&x<=28+sx_chara) && (19<=y&&y<=42))) begin
                oled_data = 16'b00000_111111_00000;
                border_chara = 1;
            end
        else if (btnR && border_chara && lagr == 0 && sx_chara < 16) begin
            lagr = 1;
            sx_chara = sx_chara + 35;
            character = 1;
        end
        else if (btnR == 0 && border_chara && lagr) lagr = 0;
        else if (btnL && border_chara && lagl == 0 && sx_chara > 49) begin
            lagl = 1;
            sx_chara = sx_chara - 35;
            character = 0;
        end
        else if (btnL == 0 && border_chara && lagl) lagl = 0;
        else if (pixel_index == 2144 || pixel_index == 2240 || pixel_index == 2337 || ((pixel_index >= 2433) && (pixel_index <= 2434)) || ((pixel_index >= 2708) && (pixel_index <= 2709)) || ((pixel_index >= 2805) && (pixel_index <= 2806)) || ((pixel_index >= 2821) && (pixel_index <= 2822)) || pixel_index == 2824 || ((pixel_index >= 2903) && (pixel_index <= 2904)) || pixel_index == 2919 || pixel_index == 3015) oled_data = 16'b1111010100000000;
        else if (pixel_index == 2275 || pixel_index == 2372 || pixel_index == 2468 || ((pixel_index >= 2564) && (pixel_index <= 2565)) || ((pixel_index >= 2743) && (pixel_index <= 2744)) || ((pixel_index >= 2839) && (pixel_index <= 2840)) || ((pixel_index >= 2936) && (pixel_index <= 2937)) || pixel_index == 2952 || pixel_index == 2954 || ((pixel_index >= 3034) && (pixel_index <= 3035)) || pixel_index == 3049) oled_data = 16'b0101001010010100;
        else if (((pixel_index >= 2435) && (pixel_index <= 2436)) || ((pixel_index >= 2528) && (pixel_index <= 2530)) || pixel_index == 2534 || ((pixel_index >= 2624) && (pixel_index <= 2626)) || pixel_index == 2630 || ((pixel_index >= 2710) && (pixel_index <= 2712)) || pixel_index == 2717 || ((pixel_index >= 2719) && (pixel_index <= 2722)) || ((pixel_index >= 2726) && (pixel_index <= 2729)) || ((pixel_index >= 2807) && (pixel_index <= 2810)) || ((pixel_index >= 2812) && (pixel_index <= 2813)) || ((pixel_index >= 2816) && (pixel_index <= 2820)) || pixel_index == 2825 || ((pixel_index >= 2905) && (pixel_index <= 2910)) || ((pixel_index >= 2912) && (pixel_index <= 2917)) || pixel_index == 2920 || ((pixel_index >= 3001) && (pixel_index <= 3006)) || ((pixel_index >= 3008) && (pixel_index <= 3013)) || ((pixel_index >= 3097) && (pixel_index <= 3110)) || pixel_index == 3196 || ((pixel_index >= 3198) && (pixel_index <= 3201)) || ((pixel_index >= 3293) && (pixel_index <= 3294)) || pixel_index == 3297 || ((pixel_index >= 3389) && (pixel_index <= 3390)) || pixel_index == 3393 || ((pixel_index >= 3484) && (pixel_index <= 3485)) || pixel_index == 3581 || ((pixel_index >= 3676) && (pixel_index <= 3678)) || (pixel_index >= 3772) && (pixel_index <= 3774)) oled_data = 16'b1111000000000000;
        else if (pixel_index == 2533 || pixel_index == 2535 || pixel_index == 2629 || pixel_index == 2631 || pixel_index == 2725 || pixel_index == 3016 || pixel_index == 3111) oled_data = 16'b1010000000000000;
        else if (((pixel_index >= 2566) && (pixel_index <= 2567)) || ((pixel_index >= 2659) && (pixel_index <= 2661)) || ((pixel_index >= 2664) && (pixel_index <= 2665)) || ((pixel_index >= 2745) && (pixel_index <= 2747)) || pixel_index == 2752 || ((pixel_index >= 2754) && (pixel_index <= 2757)) || ((pixel_index >= 2760) && (pixel_index <= 2763)) || ((pixel_index >= 2841) && (pixel_index <= 2843)) || pixel_index == 2848 || ((pixel_index >= 2851) && (pixel_index <= 2853)) || ((pixel_index >= 2856) && (pixel_index <= 2859)) || ((pixel_index >= 2938) && (pixel_index <= 2941)) || ((pixel_index >= 2943) && (pixel_index <= 2944)) || ((pixel_index >= 2947) && (pixel_index <= 2951)) || pixel_index == 2953 || pixel_index == 2955 || ((pixel_index >= 3036) && (pixel_index <= 3041)) || ((pixel_index >= 3043) && (pixel_index <= 3048)) || pixel_index == 3050 || ((pixel_index >= 3132) && (pixel_index <= 3145)) || pixel_index == 3231 || ((pixel_index >= 3233) && (pixel_index <= 3236)) || pixel_index == 3327 || ((pixel_index >= 3329) && (pixel_index <= 3332)) || ((pixel_index >= 3424) && (pixel_index <= 3425)) || pixel_index == 3428 || ((pixel_index >= 3519) && (pixel_index <= 3520)) || pixel_index == 3616 || pixel_index == 3712 || (pixel_index >= 3807) && (pixel_index <= 3809)) oled_data = 16'b0101010100010100;
        else if (pixel_index == 2823 || pixel_index == 2918 || pixel_index == 3014) oled_data = 16'b1111001010000000;
        else if (pixel_index == 2850) oled_data = 16'b0101010100001010;
        else if ((pixel_index >= 2854) && (pixel_index <= 2855)) oled_data = 16'b0000001010000000;
        else if ((pixel_index >= 2999) && (pixel_index <= 3000)) oled_data = 16'b1010010100000000;
        else oled_data = 0;       
     end
    
endmodule

