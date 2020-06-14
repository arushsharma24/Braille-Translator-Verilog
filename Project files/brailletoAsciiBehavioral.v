`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2020 20:03:57
// Design Name: 
// Module Name: brailletoAscii
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

module brailleToBinary(braillie, bin1, bin2);
    input [5:0] braillie;
    output [3:0] bin1,bin2;
    
    wire a,b,c,d,e,f;
    assign a = braillie[5];
    assign b = braillie[4];
    assign c = braillie[3];
    assign d = braillie[2];
    assign e = braillie[1];
    assign f = braillie[0];
    assign bin1[3] = (b & c & d & ~f) | (a & ~b & c & f) | (a & c & ~d & ~e & f) | (~a & b & ~c & d & e & f);
    assign bin1[2] = (a & ~b & ~f) | (a & ~c & ~f) | (b & ~c & d & ~f) | (a & ~d & ~e & ~f);
    assign bin1[1] = (a & ~b & ~f) | (a & ~c & ~f) | (b & ~c & d & ~f) | (a & ~d & ~e & ~f);
    assign bin1[0] = (b & ~c & d & ~f) | (a & ~b & c & ~f) | (a & c & ~d & ~e & ~f) | (a & ~b & c & ~d & e) | (a & b & ~c & e & ~f);
    
    assign bin2[3] = (a & ~b & e & ~f) | (a & ~b & c & d & f);
    assign bin2[2] = (a & ~b & ~e & ~f) | (a & ~d & ~e & ~f) | (a & c & ~d & ~e) | (~a & b & ~c & d & e) | ( ~a & b & d & e & ~f);
    assign bin2[1] = (a & b & ~d & ~f) | (~a & b & d & ~e & ~f) | (a & ~b & d & ~e & ~f) | (a & b & c & ~d & ~e) | (~a & b & ~c & d & e & f);
    assign bin2[0] = (a & ~b & ~d & ~f) | (a & ~b & ~e & ~f) | (~a & b & d & ~e & ~f) | (a & ~b & c & ~d & ~e) | (a & b & d & e & ~f) | (~a & b & ~c & d & e & f) | (a & ~b & c & d & e & f);
endmodule

module binto7segment(
    input  [3:0]x,
    output reg [6:0]z
    );
    always @*
        case (x)
        4'b0000 :      	
        z = 7'b1111110;
        4'b0001 :    	
        z = 7'b0110000  ;
        4'b0010 :  		
        z = 7'b1101101 ; 
        4'b0011 : 		
        z = 7'b1111001 ;
        4'b0100 :		
        z = 7'b0110011 ;
        4'b0101 :		
        z = 7'b1011011 ;  
        4'b0110 :		
        z = 7'b1011111 ;
        4'b0111 :		
        z = 7'b1110000;
        4'b1000 :     	
        z = 7'b1111111;
        4'b1001 :    	
        z = 7'b1111011 ;
    endcase
endmodule

module brailletoAscii(digit_1, digit_2, braille);
    input [5:0]braille;
    output wire [6:0]digit_1;
    output wire [6:0]digit_2;
    wire [3:0]b1,b2;
    brailleToBinary   mod1(braille,b1,b2);
    binto7segment  mod2(b1,digit_1);
    binto7segment  mod3(b2,digit_2);
endmodule

