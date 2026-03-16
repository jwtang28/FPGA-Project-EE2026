`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 11:25:20
// Design Name: 
// Module Name: coor
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


module coor(
    input [12:0]pixel_index,
    output [12:0] x, [12:0]y
    );
    assign x = pixel_index%96;
    assign y = pixel_index/96;
endmodule
