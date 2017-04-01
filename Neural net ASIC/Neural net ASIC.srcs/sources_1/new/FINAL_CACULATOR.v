`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 11/28/2016 07:37:55 PM
// Design Name: 
// Module Name: FINAL_CACULATOR
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


module FINAL_CALCULATOR(
    COMP_IN,     //comparator outputs
    CLK,
    CE,
    PATTERN,
    CNT_FINISH
    );
    
    parameter ARRAY_SIZE = 16;
    input [ARRAY_SIZE-1:0] COMP_IN;     //comparator outputs
    input CLK;
    input CE;
    output [ARRAY_SIZE-1:0] PATTERN;
    output CNT_FINISH;
    
    reg  REG [ARRAY_SIZE-1:0][1:0]; 
    reg [ARRAY_SIZE-1:0] LOGICAL;
    reg [ARRAY_SIZE-1:0] PATTERN_REG;
    reg CNT_FINISH_REG;
    
    integer i,j;
    always@(posedge CLK)
    begin
        if(CE)
        begin
            for(i=0;i<ARRAY_SIZE;i=i+1)
            begin
                REG[i][1] <= REG[i][0];
                REG[i][0] <= COMP_IN[i];
            end
        end
    end
    
    always@(*)
    begin
        for(i=0;i<ARRAY_SIZE;i=i+1)
        begin
            LOGICAL[i] = !(REG[i][0] ^ REG[i][1]);  //xnor to check if both are the same
        end
        
        if(&LOGICAL)
        begin
            CNT_FINISH_REG = 1'b1;
            for(i=0;i<ARRAY_SIZE;i=i+1)
            begin
                PATTERN_REG[i] = REG[i][1];
            end
        end
        else
        begin
            CNT_FINISH_REG = 1'b0;
            PATTERN_REG = 7'd0;
        end
    end
    
    assign CNT_FINISH = CNT_FINISH_REG;
    assign PATTERN = PATTERN_REG;
    
endmodule
