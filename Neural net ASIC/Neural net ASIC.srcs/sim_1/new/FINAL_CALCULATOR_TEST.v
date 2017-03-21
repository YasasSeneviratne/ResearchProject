`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2016 11:13:46 AM
// Design Name: 
// Module Name: FINAL_CALCULATOR_TEST
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


module FINAL_CALCULATOR_TEST;
    parameter ARRAY_SIZE = 7;
    reg [ARRAY_SIZE-1:0] COMP_IN;     //comparator outputs
    reg CLK;
    reg CE;
    wire [ARRAY_SIZE-1:0] PATTERN;
    wire CNT_FINISH;
    
    integer i;
    initial
    begin
        COMP_IN = 7'b0000000;     //comparator outputs
        CLK = 1'b0;
        CE =1'b1;  
        
        for(i=0;i<10;i=i+1)
        begin
            #100
            CLK = !CLK;
            if(COMP_IN == 7'd7)
                COMP_IN = COMP_IN;
            else
                COMP_IN = COMP_IN + 1;
            #100
            CLK = !CLK;
        end    
    end    
    
    FINAL_CALCULATOR uut(
    COMP_IN,     //comparator outputs
    CLK,
    CE,
    PATTERN,
    CNT_FINISH
    );
endmodule
