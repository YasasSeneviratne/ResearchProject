`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 11/26/2016 11:38:26 AM
// Design Name: 
// Module Name: PE
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
module PE #(
    parameter REG_SIZE = 6
    )(
    IN_SHIFT_REG,
    IN_FIFO,
    IN_DATA,
    CE,
    CLK,
    IN_REG,
    OP_REG,
    OP_FIFO,
    CNT_STATE,
    CNT_SETREG
     );
    
    input [REG_SIZE-1:0] IN_SHIFT_REG;
    input [REG_SIZE-1:0] IN_FIFO;
    input IN_DATA;
    input CE;
    input CLK;
    input  [REG_SIZE-1:0] IN_REG;
    output [REG_SIZE-1:0] OP_REG;
    output [REG_SIZE-1:0] OP_FIFO;
    input CNT_STATE;        //controle state 0 for training 1 for detection
    input CNT_SETREG;       // set the latch
   
    
    reg [REG_SIZE-1:0] OP_REG_L;
    reg [REG_SIZE-1:0] OP_FIFO_L;
    //reg [REG_SIZE-1:0] ONE      = 6'b000001;
    //reg [REG_SIZE-1:0] MIN_ONE  = 6'b111111;
    reg                L        = 1'b0;
    
    always@(IN_SHIFT_REG or IN_FIFO or IN_DATA or CE or IN_REG or CNT_STATE or CNT_SETREG)
    begin
        if(CE)
        begin
            if(CNT_STATE==1'b0)//Training stage
            begin
//                if(CNT_SETREG)
//                    L = IN_DATA;
                OP_REG_L = 6'd0;
                if(CNT_SETREG)
                    OP_FIFO_L = 1'b0;
                else if(L==IN_DATA)
                    OP_FIFO_L = IN_FIFO + 6'b000001;
                else
                    OP_FIFO_L = IN_FIFO + 6'b111111;
            end
            else      //detecting
            begin
                OP_FIFO_L = 6'd0;
                if(IN_DATA)
                    OP_REG_L = IN_REG + IN_SHIFT_REG;
                else if(IN_DATA == 1'b0)
                    OP_REG_L = IN_REG + (~IN_SHIFT_REG+6'd1);   //2's complement convertion
            end   
        end 
        else
        begin
            OP_FIFO_L = 6'd0;
            OP_REG_L = 6'd0;
        end        
    end  
    
    always@(posedge CNT_SETREG)
    begin
        if(CE)
        begin
            if(CNT_STATE==1'b0)//Training stage
            begin
//                if(CNT_SETREG)
                        L = IN_DATA;
            end
        end
    end
    
    assign OP_REG = OP_REG_L;
    assign OP_FIFO = OP_FIFO_L;  
endmodule
