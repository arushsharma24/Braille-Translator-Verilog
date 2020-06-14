`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2020 14:24:01
// Design Name: 
// Module Name: brailletoAsciiStructural
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
    //A,B,C,D,E,F are Complements of a,b,c,d,e,f
    wire A,B,C,D,E,F;
    //AND1 are wires after first level(and gates) of bin1
    //Similarly AND2 are wires after first level(and gates) of bin2
    wire[12:0] AND1;
    wire[18:0] AND2;
    assign a = braillie[5];
    assign b = braillie[4];
    assign c = braillie[3];
    assign d = braillie[2];
    assign e = braillie[1];
    assign f = braillie[0];
    not(A,a);
    not(B,b);
    not(C,c);
    not(D,d);
    not(E,e);
    not(F,f);
    
    //bin1[3]
    //assign bin1[3] = (b & c & d & ~f) | (a & ~b & c & f) | (a & c & ~d & ~e & f) | (~a & b & ~c & d & e & f);
    and(AND1[12], b,c,d,F);
    and(AND1[11], a,B,c,f);
    and(AND1[10], a,c,D,E,f);
    and(AND1[9], A,b,C,d,e,f);
    or(bin1[3], AND1[9],AND1[10],AND1[11],AND1[12]);
    
    //bin1[2],bin1[1]
    //assign bin1[2] = (a & ~b & ~f) | (a & ~c & ~f) | (b & ~c & d & ~f) | (a & ~d & ~e & ~f);
    //assign bin1[1] = (a & ~b & ~f) | (a & ~c & ~f) | (b & ~c & d & ~f) | (a & ~d & ~e & ~f);
    and(AND1[8], a,B,F);
    and(AND1[7], a,C,F);
    and(AND1[6], b,C,d,F);
    and(AND1[5], a,D,E,F);
    or(bin1[2], AND1[8],AND1[7],AND1[6],AND1[5]);
    assign bin1[1] = bin1[2];
    
    //bin1[0]
    //assign bin1[0] = (b & ~c & d & ~f) | (a & ~b & c & ~f) | (a & c & ~d & ~e & ~f) | (a & ~b & c & ~d & e) | (a & b & ~c & e & ~f);
    and(AND1[4], b,C,d,F);
    and(AND1[3], a,B,c,F);
    and(AND1[2], a,c,D,E,F);
    and(AND1[1], a,B,c,D,e);
    and(AND1[0], a,b,C,e,F);
    or(bin1[0], AND1[4],AND1[3],AND1[2],AND1[1],AND1[0]);
    
    
    //bin2[3]
    //assign bin2[3] = (a & ~b & e & ~f) | (a & ~b & c & d & f);
    and(AND2[18], a,B,e,F);
    and(AND2[17], a,B,c,d,f);
    or(bin2[3], AND2[18],AND2[17]);
    
    //bin2[2]
    //assign bin2[2] = (a & ~b & ~e & ~f) | (a & ~d & ~e & ~f) | (a & c & ~d & ~e) | (~a & b & ~c & d & e) | ( ~a & b & d & e & ~f);
    and(AND2[16], a,B,E,F);
    and(AND2[15], a,D,E,F);
    and(AND2[14], a,c,D,E);
    and(AND2[13], A,b,C,d,e);
    and(AND2[12], A,b,d,e,F);
    or(bin2[2], AND2[16],AND2[15],AND2[14],AND2[13],AND2[12]);
    
    //bin2[1]
    //assign bin2[1] = (a & b & ~d & ~f) | (~a & b & d & ~e & ~f) | (a & ~b & d & ~e & ~f) | (a & b & c & ~d & ~e) | (~a & b & ~c & d & e & f);
    and(AND2[11], a,b,D,F);
    and(AND2[10], A,b,d,E,F);
    and(AND2[9], a,B,d,E,F);
    and(AND2[8], a,b,c,D,E);
    and(AND2[7], A,b,C,d,e,f);
    or(bin2[1], AND2[11],AND2[10],AND2[9],AND2[8],AND2[7]);
    
    //bin2[0]
    //assign bin2[0] = (a & ~b & ~d & ~f) | (a & ~b & ~e & ~f) | (~a & b & d & ~e & ~f) | (a & ~b & c & ~d & ~e) | (a & b & d & e & ~f) | (~a & b & ~c & d & e & f) | (a & ~b & c & d & e & f);
    and(AND2[6], a,B,D,F);
    and(AND2[5], a,B,E,F);
    and(AND2[4], A,b,d,E,F);
    and(AND2[3], a,B,c,D,E);
    and(AND2[2], a,b,d,e,F);
    and(AND2[1], A,b,C,d,e,f);
    and(AND2[0], a,B,c,d,e,f);
    or(bin2[0], AND2[6],AND2[5],AND2[4],AND2[3],AND2[2],AND2[1],AND2[0]);
endmodule

module binto7segment(
    input  wire [3:0]bin,
    output wire [6:0]segment
    );
    wire p,q,r,s;
    //P,Q,R,S are complements of p,q,r,s
    wire P,Q,R,S;
    //Wires after And Gates
    wire [0:34]AND3;
    assign p = bin[3];
    assign q = bin[2];
    assign r = bin[1];
    assign s = bin[0];
    not(P,p);
    not(Q,q);
    not(R,r);
    not(S,s);
    
    //segment[6]
    and(AND3[0],Q,S);
    and(AND3[1],P,r);
    and(AND3[2],q,r);
    and(AND3[3],p,S);
    and(AND3[4],P,q,r);
    and(AND3[5],p,Q,R);
    or(segment[6], AND3[0],AND3[1],AND3[2],AND3[3]);
    
    //segment[5]
    and(AND3[6],P,Q);
    and(AND3[7],Q,S);
    and(AND3[8],P,R,S);
    and(AND3[9],P,r,s);
    and(AND3[10],p,R,s);
    or(segment[5], AND3[4],AND3[5],AND3[6],AND3[7]);
    
    //segment[4]
    and(AND3[11],P,R);
    and(AND3[12],P,s);
    and(AND3[13],R,s);
    and(AND3[14],P,q);
    and(AND3[15],p,Q);
    or(segment[4], AND3[11],AND3[12],AND3[13],AND3[14],AND3[15]);
    
    //segment[3]
    and(AND3[16],p,R);
    and(AND3[17],P,Q,S);
    and(AND3[18],Q,r,s);
    and(AND3[19],q,R,s);
    and(AND3[20],q,r,S);
    or(segment[3], AND3[16],AND3[17],AND3[18],AND3[19],AND3[20]);
    
    //segment[2]
    and(AND3[21],Q,S);
    and(AND3[22],r,S);
    and(AND3[23],p,r);
    and(AND3[24],p,q);
    or(segment[2], AND3[21],AND3[22],AND3[23],AND3[24]);
    
    //segment[1]
    and(AND3[25],R,S);
    and(AND3[26],q,S);
    and(AND3[27],p,Q);
    and(AND3[28],p,r);
    and(AND3[29],P,q,R);
    or(segment[1], AND3[25],AND3[26],AND3[27],AND3[28],AND3[29]);
    
    //segment[0]
    and(AND3[30],Q,r);
    and(AND3[31],r,S);
    and(AND3[32],p,Q);
    and(AND3[33],p,s);
    and(AND3[34],P,q,R);
    or(segment[0], AND3[30],AND3[31],AND3[32],AND3[33],AND3[34]);
    
endmodule

module brailletoAsciiStructural(digit_1, digit_2, braille);
    input [5:0]braille;
    output wire [6:0]digit_1;
    output wire [6:0]digit_2;
    wire [3:0]b1,b2;
    brailleToBinary   mod1(braille,b1,b2);
    binto7segment  mod2(b1,digit_1);
    binto7segment  mod3(b2,digit_2);
endmodule
