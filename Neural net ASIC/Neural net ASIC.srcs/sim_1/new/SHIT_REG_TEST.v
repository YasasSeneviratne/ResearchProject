`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2016 09:32:06 AM
// Design Name: 
// Module Name: SHIT_REG_TEST
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


module SHIT_REG_TEST;
    parameter REG_SIZE = 6;
    
    reg [1:0] CNT_STATE; 
    reg CE;
    reg CLK;
    
    reg [REG_SIZE-1:0]DATA_IN0;
    reg [REG_SIZE-1:0]DATA_IN1;
    reg [REG_SIZE-1:0]DATA_IN2;
    reg [REG_SIZE-1:0]DATA_IN3;
    reg [REG_SIZE-1:0]DATA_IN4;
    reg [REG_SIZE-1:0]DATA_IN5;
    reg [REG_SIZE-1:0]DATA_IN6;
       
    wire [REG_SIZE-1:0]DATA_OUT0;
    wire [REG_SIZE-1:0]DATA_OUT1;
    wire [REG_SIZE-1:0]DATA_OUT2;
    wire [REG_SIZE-1:0]DATA_OUT3;
    wire [REG_SIZE-1:0]DATA_OUT4;
    wire [REG_SIZE-1:0]DATA_OUT5;
    wire [REG_SIZE-1:0]DATA_OUT6; 
    
    integer i;
    initial
    begin
        CLK = 1'b0;
        CE = 1'b1;
        CNT_STATE = 2'b00;
        
        DATA_IN0 = 1;
        DATA_IN1 = 1;
        DATA_IN2 = 1;
        DATA_IN3 = 1;
        DATA_IN4 = 1;
        DATA_IN5 = 1;
        DATA_IN6 = 1;
    
    for(i=0;i<6;i=i+1)
    begin  
        #100
        CLK = !CLK;
        DATA_IN0 <= DATA_IN0 +1;
        DATA_IN1 <= DATA_IN1 +1;
        DATA_IN2 <= DATA_IN2 +1;
        DATA_IN3 <= DATA_IN3 +1;
        DATA_IN4 <= DATA_IN4 +1;
        DATA_IN5 <= DATA_IN5 +1;
        DATA_IN6 <= DATA_IN6 +1;
        
        #100
        CLK= !CLK;
    end
    
    #100
        CLK= !CLK;
        CNT_STATE = 2'b01;
    #100
        CLK=!CLK;
    #100
        CLK=!CLK;
        CNT_STATE = 2'b10;
    #100
        CLK=!CLK;
    #100
        CLK=!CLK;        
    #100
        CLK=!CLK;
    #100
        CLK=!CLK;        
    #100
        CLK=!CLK;
    end
   /* always()
    begin
        #100 
        CLK = !CLK;
    end*/
    SHIFT_REG #(REG_SIZE,7) uut(
        DATA_IN0,
        DATA_IN1,
        DATA_IN2,
        DATA_IN3,
        DATA_IN4,
        DATA_IN5,
        DATA_IN6,
           
        DATA_OUT0,
        DATA_OUT1,
        DATA_OUT2,
        DATA_OUT3,
        DATA_OUT4,
        DATA_OUT5,
        DATA_OUT6,
        
        CNT_STATE, 
        CE,
        CLK
    );
    
endmodule
