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
 //   DATA_IN6,
    
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
    
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 7;
    
    input [1:0] CNT_STATE; 
    input CE;
    input CLK;
    
    input [REG_SIZE-1:0]DATA_IN0;
    input [REG_SIZE-1:0]DATA_IN1;
    input [REG_SIZE-1:0]DATA_IN2;
    input [REG_SIZE-1:0]DATA_IN3;
    input [REG_SIZE-1:0]DATA_IN4;
    input [REG_SIZE-1:0]DATA_IN5;
 //   input [REG_SIZE-1:0]DATA_IN6;
       
    output [REG_SIZE-1:0]DATA_OUT0;
    output [REG_SIZE-1:0]DATA_OUT1;
    output [REG_SIZE-1:0]DATA_OUT2;
    output [REG_SIZE-1:0]DATA_OUT3;
    output [REG_SIZE-1:0]DATA_OUT4;
    output [REG_SIZE-1:0]DATA_OUT5;
    output [REG_SIZE-1:0]DATA_OUT6;   
    
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
                            REG[i][j] <= 6'd0;
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
    assign DATA_OUT1 = REG[0][1];
    assign DATA_OUT2 = REG[0][2];
    assign DATA_OUT3 = REG[0][3];
    assign DATA_OUT4 = REG[0][4];
    assign DATA_OUT5 = REG[0][5];
    assign DATA_OUT6 = REG[0][6];
endmodule