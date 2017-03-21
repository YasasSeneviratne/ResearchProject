`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 06:55:37 PM
// Design Name: 
// Module Name: FIFO_ARRAY_TEST
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


module FIFO_ARRAY_TEST;
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 7;
    
    reg [REG_SIZE-1:0] FIFO_IN0;
    reg [REG_SIZE-1:0] FIFO_IN1;
    reg [REG_SIZE-1:0] FIFO_IN2;
    reg [REG_SIZE-1:0] FIFO_IN3;
    reg [REG_SIZE-1:0] FIFO_IN4;
    reg [REG_SIZE-1:0] FIFO_IN5;
    
    reg [ARRAY_SIZE-2:0] CE_FIFO;
    reg CE;
    reg CLK;
    
    wire [REG_SIZE-1:0] FIFO_OUT0;
    wire [REG_SIZE-1:0] FIFO_OUT1;
    wire [REG_SIZE-1:0] FIFO_OUT2;
    wire [REG_SIZE-1:0] FIFO_OUT3;
    wire [REG_SIZE-1:0] FIFO_OUT4;
    wire [REG_SIZE-1:0] FIFO_OUT5;
    
    integer i;
    initial
    begin
        FIFO_IN0 = 6'b1;
        FIFO_IN1 = 6'b1;
        FIFO_IN2 = 6'b1;
        FIFO_IN3 = 6'b1;
        FIFO_IN4 = 6'b1;
        FIFO_IN5 = 6'b1;
        
        CE_FIFO = 6'b111110;
        CE = 1'b1;
        CLK = 1'b0;
        
        for(i=0;i<7;i=i+1)
        begin
            #100
            CLK = !CLK;
            #100
            CLK = !CLK;
        end
    end
    
    FIFO_ARRAY uut(
        FIFO_IN0,
        FIFO_IN1,
        FIFO_IN2,
        FIFO_IN3,
        FIFO_IN4,
        FIFO_IN5,
        
        FIFO_OUT0,
        FIFO_OUT1,
        FIFO_OUT2,
        FIFO_OUT3,
        FIFO_OUT4,
        FIFO_OUT5,
        
        CE_FIFO,
        CE,
        CLK
        );
    
endmodule
