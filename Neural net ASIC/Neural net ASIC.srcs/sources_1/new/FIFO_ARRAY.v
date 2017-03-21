`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2016 06:41:01 PM
// Design Name: 
// Module Name: FIFO_ARRAY
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


module FIFO_ARRAY(
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
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 7;
    
    input [REG_SIZE-1:0] FIFO_IN0;
    input [REG_SIZE-1:0] FIFO_IN1;
    input [REG_SIZE-1:0] FIFO_IN2;
    input [REG_SIZE-1:0] FIFO_IN3;
    input [REG_SIZE-1:0] FIFO_IN4;
    input [REG_SIZE-1:0] FIFO_IN5;
    
    input [ARRAY_SIZE-2:0] CE_FIFO;
    input CE;
    input CLK;
    
    output [REG_SIZE-1:0] FIFO_OUT0;
    output [REG_SIZE-1:0] FIFO_OUT1;
    output [REG_SIZE-1:0] FIFO_OUT2;
    output [REG_SIZE-1:0] FIFO_OUT3;
    output [REG_SIZE-1:0] FIFO_OUT4;
    output [REG_SIZE-1:0] FIFO_OUT5;
    
    reg [REG_SIZE-1:0] FIFO0 [ARRAY_SIZE-1:0];
    reg [REG_SIZE-1:0] FIFO1 [ARRAY_SIZE-2:0];
    reg [REG_SIZE-1:0] FIFO2 [ARRAY_SIZE-3:0];
    reg [REG_SIZE-1:0] FIFO3 [ARRAY_SIZE-4:0];
    reg [REG_SIZE-1:0] FIFO4 [ARRAY_SIZE-5:0];
    reg [REG_SIZE-1:0] FIFO5 [ARRAY_SIZE-6:0];
    
    integer i;
    always@(posedge CLK)
    begin
        if(CE)
        begin
            if(CE_FIFO[0]==1'b1)
            begin
                FIFO0[ARRAY_SIZE-1] <= FIFO_IN0;
                for(i=0;i<ARRAY_SIZE-1;i=i+1)
                    FIFO0[i]<=FIFO0[i+1];
            end
            if(CE_FIFO[1]==1'b1)
            begin
                FIFO1[ARRAY_SIZE-2] <= FIFO_IN1;
                for(i=0;i<ARRAY_SIZE-2;i=i+1)
                    FIFO1[i]<=FIFO1[i+1];
            end
            if(CE_FIFO[2]==1'b1)
            begin
                FIFO2[ARRAY_SIZE-3] <= FIFO_IN2;
                for(i=0;i<ARRAY_SIZE-3;i=i+1)
                    FIFO2[i]<=FIFO2[i+1];
            end
            if(CE_FIFO[3]==1'b1)
            begin
                FIFO3[ARRAY_SIZE-4] <= FIFO_IN3;
                for(i=0;i<ARRAY_SIZE-4;i=i+1)
                   FIFO3[i]<=FIFO3[i+1];
            end
            if(CE_FIFO[4]==1'b1)
            begin
                FIFO4[ARRAY_SIZE-5] <= FIFO_IN4;
                for(i=0;i<ARRAY_SIZE-5;i=i+1)
                   FIFO4[i]<=FIFO4[i+1];
            end
            if(CE_FIFO[5]==1'b1)
            begin
                FIFO5[ARRAY_SIZE-6] <= FIFO_IN5;
                for(i=0;i<ARRAY_SIZE-6;i=i+1)
                   FIFO5[i]<=FIFO5[i+1];
            end
            
        end
    end 
    
    assign FIFO_OUT0 = FIFO0[0];
    assign FIFO_OUT1 = FIFO1[0];
    assign FIFO_OUT2 = FIFO2[0];
    assign FIFO_OUT3 = FIFO3[0];
    assign FIFO_OUT4 = FIFO4[0];
    assign FIFO_OUT5 = FIFO5[0];
endmodule
