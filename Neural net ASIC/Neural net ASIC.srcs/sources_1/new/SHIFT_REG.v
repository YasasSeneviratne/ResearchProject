`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2016 08:19:25 PM
// Design Name: 
// Module Name: SHIFT_REG
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


module SHIFT_REG(
    DATA_IN0, //from FIFO 1
    DATA_IN1, //vica versa
    DATA_IN2,
    DATA_IN3,
    DATA_IN4,
    DATA_IN5,
    DATA_IN6,
    DATA_IN7,
    DATA_IN8,
    DATA_IN9,
    DATA_IN10,
    DATA_IN11,
    DATA_IN12,
    DATA_IN13,
    DATA_IN14,
    
 //   DATA_IN6,
    
    DATA_OUT0,
    DATA_OUT1,
    DATA_OUT2,
    DATA_OUT3,
    DATA_OUT4,
    DATA_OUT5,
    DATA_OUT6,
    DATA_OUT7,
    DATA_OUT8,
    DATA_OUT9,
    DATA_OUT10,
    DATA_OUT11,
    DATA_OUT12,
    DATA_OUT13,
    DATA_OUT14,
    DATA_OUT15,
    
    CNT_STATE,
    CE,
    CLK
    );
    
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 16;
    
    input [1:0] CNT_STATE; 
    input CE;
    input CLK;
    
    input [REG_SIZE-1:0]DATA_IN0;
    input [REG_SIZE-1:0]DATA_IN1;
    input [REG_SIZE-1:0]DATA_IN2;
    input [REG_SIZE-1:0]DATA_IN3;
    input [REG_SIZE-1:0]DATA_IN4;
    input [REG_SIZE-1:0]DATA_IN5;
    input [REG_SIZE-1:0]DATA_IN6;
    input [REG_SIZE-1:0]DATA_IN7;
    input [REG_SIZE-1:0]DATA_IN8;
    input [REG_SIZE-1:0]DATA_IN9;
    input [REG_SIZE-1:0]DATA_IN10;
    input [REG_SIZE-1:0]DATA_IN11;
    input [REG_SIZE-1:0]DATA_IN12;
    input [REG_SIZE-1:0]DATA_IN13;
    input [REG_SIZE-1:0]DATA_IN14;
    
 //   input [REG_SIZE-1:0]DATA_IN6;
       
    output [REG_SIZE-1:0]DATA_OUT0;
    output [REG_SIZE-1:0]DATA_OUT1;
    output [REG_SIZE-1:0]DATA_OUT2;
    output [REG_SIZE-1:0]DATA_OUT3;
    output [REG_SIZE-1:0]DATA_OUT4;
    output [REG_SIZE-1:0]DATA_OUT5;
    output [REG_SIZE-1:0]DATA_OUT6;   
    output [REG_SIZE-1:0]DATA_OUT7;   
    output [REG_SIZE-1:0]DATA_OUT8;   
    output [REG_SIZE-1:0]DATA_OUT9;   
    output [REG_SIZE-1:0]DATA_OUT10;   
    output [REG_SIZE-1:0]DATA_OUT11;   
    output [REG_SIZE-1:0]DATA_OUT12;   
    output [REG_SIZE-1:0]DATA_OUT13;   
    output [REG_SIZE-1:0]DATA_OUT14;   
    output [REG_SIZE-1:0]DATA_OUT15; 
    
    reg [REG_SIZE-1:0] REG [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    integer i,j;
    reg [REG_SIZE-1:0] L [ARRAY_SIZE-1:0];
    
    always@(posedge CLK)
    begin
        if(CE)
        begin
          case(CNT_STATE)
            2'b00:              //Write to weight array state
            begin
                for(i=0;i<ARRAY_SIZE;i=i+1)
                begin
                    REG[i][ARRAY_SIZE-1] <= REG[i][0];
                    for(j=0;j<ARRAY_SIZE-1;j=j+1)
                    begin
                        REG[i][j]<=REG[i][j+1];
                    end
               //     REG[i][ARRAY_SIZE-1]<=L[i]; 
                end
                
    //when all FIFOs are empty the lover tranguler section of the metrix will be compleated
                REG[0][ARRAY_SIZE-1] <= DATA_IN0;
                REG[1][0] <= DATA_IN1;
                REG[2][1] <= DATA_IN2;
                REG[3][2] <= DATA_IN3;
                REG[4][3] <= DATA_IN4;
                REG[5][4] <= DATA_IN5;
                REG[6][5] <= DATA_IN6;
                REG[7][6] <= DATA_IN7;
                REG[8][7] <= DATA_IN8;
                REG[9][8] <= DATA_IN9;
                REG[10][9] <= DATA_IN10;
                REG[11][10] <= DATA_IN11;
                REG[12][11] <= DATA_IN12;
                REG[13][12] <= DATA_IN13;
                REG[14][13] <= DATA_IN14;
                
               // REG[6][5] <= DATA_IN6;                       
                    
            end
            2'b01:                //Complete the metrix state
            begin
                for(i=0;i<ARRAY_SIZE;i=i+1)
                begin
                    for(j=0;j<ARRAY_SIZE;j=j+1)
                    begin
                        if(i>j)
                            REG[i][j] <= REG[j][i];
                        else if(i==j)
                            REG[i][j] <= 16'd0;
                    end
                end
            end
            2'b10:              //recognition stage operation
            begin
                for(i=0;i<ARRAY_SIZE;i=i+1)
                begin
                     REG[i][ARRAY_SIZE-1]<= REG[i][0];
                        for(j=0;j<ARRAY_SIZE-1;j=j+1)
                            REG[i][j]<=REG[i][j+1];
                  //  REG[i][ARRAY_SIZE-1]<=L[i]; 
                end
            end
          endcase 
          /*  if(RW_EN)
            begin
                L <= REG_H[0];
                for(i=0;i<ARRAY_SIZE-1;i=i+1)
                    REG_H[i]<=REG_H[i+1];
                REG_H[ARRAY_SIZE-1]<=L;
                REG_H[WRITE_CELL] <= DATA_IN;
            end*/
        end
    end
    
    assign DATA_OUT0 = REG[0][0]; //reg[0] is where the output is taken
    assign DATA_OUT1 = REG[1][0];
    assign DATA_OUT2 = REG[2][0];
    assign DATA_OUT3 = REG[3][0];
    assign DATA_OUT4 = REG[4][0];
    assign DATA_OUT5 = REG[5][0];
    assign DATA_OUT6 = REG[6][0];
    assign DATA_OUT7 = REG[7][0];
    assign DATA_OUT8 = REG[8][0];
    assign DATA_OUT9 = REG[9][0];
    assign DATA_OUT10 = REG[10][0];
    assign DATA_OUT11 = REG[11][0];
    assign DATA_OUT12 = REG[12][0];
    assign DATA_OUT13 = REG[13][0];
    assign DATA_OUT14 = REG[14][0];
    assign DATA_OUT15 = REG[15][0];
endmodule