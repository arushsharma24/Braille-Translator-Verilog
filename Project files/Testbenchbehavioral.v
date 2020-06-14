`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2020 12:49:05
// Design Name: 
// Module Name: testbench
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


module testbench;

reg [5:0] braille;
wire [6:0]digit_1;
wire [6:0]digit_2;

//Design Under Test
brailletoAsciiStructural DUT(
    .braille(braille),
    .digit_1(digit_1),
    .digit_2(digit_2)    
);

initial
begin
    braille = 6'b100100;     //Should give 67
    #1 braille = 6'b101110;     //Should give 78
    #1 braille = 6'b101010;     //Shoulg dive 79
    #1 braille = 6'b111100;     //Should give 80
    #1 braille = 6'b111110;     //Should give 81
    #1 braille = 6'b010111;     //Should give 87
    #1 braille = 6'b101111;     //Should give 89
    #1 braille = 6'b101011;     //Should give 90
    #1 $finish;
end
initial
begin
    $monitor("digit_1=%7b,digit_2=%7b,braille = %6b ",digit_1,digit_2,braille);
end

endmodule

