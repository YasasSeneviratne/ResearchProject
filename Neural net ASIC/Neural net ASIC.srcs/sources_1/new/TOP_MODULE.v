`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2016 07:11:53 PM
// Design Name: 
// Module Name: TOP_MODULE
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


module TOP_MODULE(
    CLK,
    CNT_TOP,
    CE,
    PATTERN,
    PATTEREN_VALID
    );
    
    parameter REG_SIZE = 6;
    parameter ARRAY_SIZE = 7;
    input CLK;
    input CNT_TOP;
    input CE;
    output [ARRAY_SIZE-1:0] PATTERN;
    output PATTEREN_VALID;
    
    //processing elements
    
    PE PE0(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    PE PE1(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    PE PE2(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
        
    PE PE3(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    PE PE4(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    PE PE5(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    PE PE6(
        IN_SHIFT_REG,
        IN_FIFO,
        IN_DATA,
        CE,
        IN_REG,
        OP_REG,
        OP_FIFO,
        CNT_STATE,
        CNT_SETREG);
    
    //Shift register array
    
    SHIFT_REG SHIFT_REG_ARRAY(
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
        CLK);
    
    //FOFO array
    
    FIFO_ARRAY FIFO_ARRAY(
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
