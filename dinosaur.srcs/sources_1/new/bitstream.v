`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 10:08:46
// Design Name: 
// Module Name: lfsr
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


module lfsr(CLOCK, shift);

    input CLOCK;
    output reg [127:0]shift = 1;
    
    always @(posedge CLOCK) begin
        shift <= shift >> 1;
        shift[127] <= shift[0]^shift[1]^shift[2]^shift[7];
    end

endmodule
