`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
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
    FIFO_IN6,
    FIFO_IN7,
    FIFO_IN8,
    FIFO_IN9,
    FIFO_IN10,
    FIFO_IN11,
    FIFO_IN12,
    FIFO_IN13,
    FIFO_IN14,
    
    FIFO_OUT0,
    FIFO_OUT1,
    FIFO_OUT2,
    FIFO_OUT3,
    FIFO_OUT4,
    FIFO_OUT5,
    FIFO_OUT6,
    FIFO_OUT7,
    FIFO_OUT8,
    FIFO_OUT9,
    FIFO_OUT10,
    FIFO_OUT11,
    FIFO_OUT12,
    FIFO_OUT13,
    FIFO_OUT14,
    
    CE_FIFO,
    CE,
    CLK
    );
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 16;
    
    input [REG_SIZE-1:0] FIFO_IN0;
    input [REG_SIZE-1:0] FIFO_IN1;
    input [REG_SIZE-1:0] FIFO_IN2;
    input [REG_SIZE-1:0] FIFO_IN3;
    input [REG_SIZE-1:0] FIFO_IN4;
    input [REG_SIZE-1:0] FIFO_IN5;
    input [REG_SIZE-1:0] FIFO_IN6;
    input [REG_SIZE-1:0] FIFO_IN7;
    input [REG_SIZE-1:0] FIFO_IN8;
    input [REG_SIZE-1:0] FIFO_IN9;
    input [REG_SIZE-1:0] FIFO_IN10;
    input [REG_SIZE-1:0] FIFO_IN11;
    input [REG_SIZE-1:0] FIFO_IN12;
    input [REG_SIZE-1:0] FIFO_IN13;
    input [REG_SIZE-1:0] FIFO_IN14;
    
    input [ARRAY_SIZE-2:0] CE_FIFO;
    input CE;
    input CLK;
    
    output [REG_SIZE-1:0] FIFO_OUT0;
    output [REG_SIZE-1:0] FIFO_OUT1;
    output [REG_SIZE-1:0] FIFO_OUT2;
    output [REG_SIZE-1:0] FIFO_OUT3;
    output [REG_SIZE-1:0] FIFO_OUT4;
    output [REG_SIZE-1:0] FIFO_OUT5;
    output [REG_SIZE-1:0] FIFO_OUT6;
    output [REG_SIZE-1:0] FIFO_OUT7;
    output [REG_SIZE-1:0] FIFO_OUT8;
    output [REG_SIZE-1:0] FIFO_OUT9;
    output [REG_SIZE-1:0] FIFO_OUT10;
    output [REG_SIZE-1:0] FIFO_OUT11;
    output [REG_SIZE-1:0] FIFO_OUT12;
    output [REG_SIZE-1:0] FIFO_OUT13;
    output [REG_SIZE-1:0] FIFO_OUT14;
    
    reg [REG_SIZE-1:0] FIFO0 [ARRAY_SIZE-1:0];
    reg [REG_SIZE-1:0] FIFO1 [ARRAY_SIZE-2:0];
    reg [REG_SIZE-1:0] FIFO2 [ARRAY_SIZE-3:0];
    reg [REG_SIZE-1:0] FIFO3 [ARRAY_SIZE-4:0];
    reg [REG_SIZE-1:0] FIFO4 [ARRAY_SIZE-5:0];
    reg [REG_SIZE-1:0] FIFO5 [ARRAY_SIZE-6:0];
    reg [REG_SIZE-1:0] FIFO6 [ARRAY_SIZE-7:0];
    reg [REG_SIZE-1:0] FIFO7 [ARRAY_SIZE-8:0];
    reg [REG_SIZE-1:0] FIFO8 [ARRAY_SIZE-9:0];
    reg [REG_SIZE-1:0] FIFO9 [ARRAY_SIZE-10:0];
    reg [REG_SIZE-1:0] FIFO10 [ARRAY_SIZE-11:0];
    reg [REG_SIZE-1:0] FIFO11 [ARRAY_SIZE-12:0];
    reg [REG_SIZE-1:0] FIFO12 [ARRAY_SIZE-13:0];
    reg [REG_SIZE-1:0] FIFO13 [ARRAY_SIZE-14:0];
    reg [REG_SIZE-1:0] FIFO14 [ARRAY_SIZE-15:0];
    
    integer i;
    initial
    begin
        FIFO0[ARRAY_SIZE-1] = 32'd0;
        for(i=0;i<ARRAY_SIZE-1;i=i+1)
            FIFO0[i]=32'd0;
            
        FIFO1[ARRAY_SIZE-2] = 32'd0;
        for(i=0;i<ARRAY_SIZE-2;i=i+1)
            FIFO1[i]=32'd0;
            
        FIFO2[ARRAY_SIZE-3] = 32'd0;
        for(i=0;i<ARRAY_SIZE-3;i=i+1)
            FIFO2[i]=32'd0;
            
        FIFO3[ARRAY_SIZE-4] = 32'd0;
        for(i=0;i<ARRAY_SIZE-4;i=i+1)
            FIFO3[i]=32'd0;
            
        FIFO4[ARRAY_SIZE-5] = 32'd0;
        for(i=0;i<ARRAY_SIZE-5;i=i+1)
            FIFO4[i]=32'd0;
            
        FIFO5[ARRAY_SIZE-6] = 32'd0;
        for(i=0;i<ARRAY_SIZE-6;i=i+1)
            FIFO5[i]=32'd0;
        
        FIFO6[ARRAY_SIZE-7] = 32'd0;
        for(i=0;i<ARRAY_SIZE-7;i=i+1)
            FIFO6[i]=32'd0;    
            
        FIFO7[ARRAY_SIZE-8] = 32'd0;
        for(i=0;i<ARRAY_SIZE-8;i=i+1)
            FIFO7[i]=32'd0;
        
        FIFO8[ARRAY_SIZE-9] = 32'd0;
        for(i=0;i<ARRAY_SIZE-9;i=i+1)
            FIFO8[i]=32'd0;
            
        FIFO9[ARRAY_SIZE-10] = 32'd0;
        for(i=0;i<ARRAY_SIZE-10;i=i+1)
            FIFO9[i]=32'd0;
            
        FIFO10[ARRAY_SIZE-11] = 32'd0;
        for(i=0;i<ARRAY_SIZE-11;i=i+1)
            FIFO10[i]=32'd0;
        
        FIFO11[ARRAY_SIZE-12] = 32'd0;
        for(i=0;i<ARRAY_SIZE-12;i=i+1)
            FIFO11[i]=32'd0;
        
        FIFO12[ARRAY_SIZE-13] = 32'd0;
        for(i=0;i<ARRAY_SIZE-13;i=i+1)
            FIFO12[i]=32'd0;
        
        FIFO13[ARRAY_SIZE-14] = 32'd0;
        for(i=0;i<ARRAY_SIZE-14;i=i+1)
            FIFO13[i]=32'd0;
            
        FIFO14[ARRAY_SIZE-15] = 32'd0;
        for(i=0;i<ARRAY_SIZE-15;i=i+1)
            FIFO14[i]=32'd0;
    end
    
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
            if(CE_FIFO[6]==1'b1)
            begin
                FIFO6[ARRAY_SIZE-7] <= FIFO_IN6;
                for(i=0;i<ARRAY_SIZE-7;i=i+1)
                   FIFO6[i]<=FIFO6[i+1];
            end
            if(CE_FIFO[7]==1'b1)
            begin
                FIFO7[ARRAY_SIZE-8] <= FIFO_IN7;
                for(i=0;i<ARRAY_SIZE-8;i=i+1)
                   FIFO7[i]<=FIFO7[i+1];
            end
            if(CE_FIFO[8]==1'b1)
            begin
                FIFO8[ARRAY_SIZE-9] <= FIFO_IN8;
                for(i=0;i<ARRAY_SIZE-9;i=i+1)
                   FIFO8[i]<=FIFO8[i+1];
            end
            if(CE_FIFO[9]==1'b1)
            begin
                FIFO9[ARRAY_SIZE-10] <= FIFO_IN9;
                for(i=0;i<ARRAY_SIZE-10;i=i+1)
                   FIFO9[i]<=FIFO9[i+1];
            end
            if(CE_FIFO[10]==1'b1)
            begin
                FIFO10[ARRAY_SIZE-11] <= FIFO_IN10;
                for(i=0;i<ARRAY_SIZE-11;i=i+1)
                   FIFO10[i]<=FIFO10[i+1];
            end
            if(CE_FIFO[11]==1'b1)
            begin
                FIFO11[ARRAY_SIZE-12] <= FIFO_IN11;
                for(i=0;i<ARRAY_SIZE-12;i=i+1)
                   FIFO11[i]<=FIFO11[i+1];
            end
            if(CE_FIFO[12]==1'b1)
            begin
                FIFO12[ARRAY_SIZE-13] <= FIFO_IN12;
                for(i=0;i<ARRAY_SIZE-13;i=i+1)
                   FIFO12[i]<=FIFO12[i+1];
            end
            if(CE_FIFO[13]==1'b1)
            begin
                FIFO13[ARRAY_SIZE-14] <= FIFO_IN13;
                for(i=0;i<ARRAY_SIZE-14;i=i+1)
                   FIFO13[i]<=FIFO13[i+1];
            end
            if(CE_FIFO[14]==1'b1)
            begin
                FIFO14[ARRAY_SIZE-15] <= FIFO_IN14;
                for(i=0;i<ARRAY_SIZE-15;i=i+1)
                   FIFO14[i]<=FIFO14[i+1];
            end
        end
    end 
    
    assign FIFO_OUT0 = FIFO0[0];
    assign FIFO_OUT1 = FIFO1[0];
    assign FIFO_OUT2 = FIFO2[0];
    assign FIFO_OUT3 = FIFO3[0];
    assign FIFO_OUT4 = FIFO4[0];
    assign FIFO_OUT5 = FIFO5[0];
    assign FIFO_OUT6 = FIFO6[0];
    assign FIFO_OUT7 = FIFO7[0];
    assign FIFO_OUT8 = FIFO8[0];
    assign FIFO_OUT9 = FIFO9[0];
    assign FIFO_OUT10 = FIFO10[0];
    assign FIFO_OUT11 = FIFO11[0];
    assign FIFO_OUT12 = FIFO12[0];
    assign FIFO_OUT13 = FIFO13[0];
    assign FIFO_OUT14 = FIFO14[0];
endmodule
