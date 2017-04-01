`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 03/27/2017 08:59:32 AM
// Design Name: 
// Module Name: CONTOLLER
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


module CONTROLLER #(
    parameter NODES = 16
    )(
    input                            CLK,
    input                            FINISH,
    input           [    1    :0]    OPERATION,             //training (01), find pattern(10) or idle(00)
    input                            START_FINAL_CALC,
    output reg      [NODES - 1:0]    PE_CE,
    output reg                       PE_STATE,              //training (0), find pattern(1)  can be fullt dissbled by CE 
    output reg      [NODES - 1:0]    PE_SETREG,
    output reg                       FIFO_ARRAY_CE,
    output reg      [NODES - 1:0]    FIFO_INDI_CE,
    output reg                       SHIFT_REG_CE,
    output reg      [    1    :0]    SHIFT_REG_STATE,
    output reg                       FINAL_CAL_CE,
    output reg                       READ_DATA,
    output reg                       WEIGHTS_SET,
    output reg                       RECCURENT_CAL,
    output reg                       STATE_RECURENT_CAL
    );
    
    reg             [   4     :0]    STATE;        //operating state
    integer                          COUNTER_TRAINING;
    integer                          COUNTER_REG;
    reg             [NODES - 1:0]    PE_CE_GEN;
    reg             [   1     :0]    STATE_SHIFTREG;
    
    
    initial
    begin
        STATE               =   5'b00000;
        COUNTER_TRAINING    =   32'd0;
        COUNTER_REG         =   32'd0;
        READ_DATA           =   1'b0;
        STATE_SHIFTREG      =   2'd0;
        WEIGHTS_SET         =   1'b0;
        STATE_RECURENT_CAL  =   1'b0;
        RECCURENT_CAL       =   1'b0;
    end
    
    always@(posedge CLK)
    begin
        case(STATE)
            5'b00000:               //initial state
            begin
                if(OPERATION == 2'b01)
                begin
                    STATE <= 5'b00001;           //go to training state
                    READ_DATA <= 1'b1;
                end
                else if(OPERATION == 2'b10)
                begin
                    STATE <= 5'b00010;           //go to move to memory state
                    READ_DATA <= 1'b0;
                end 
                else if(WEIGHTS_SET && OPERATION == 2'b11)
                begin
                    STATE <= 5'b00011;
                end
                else
                begin
                    STATE <= 5'b00000;
                    READ_DATA <= 1'b0; 
                end
                
                PE_CE               <=  16'd0;
                PE_STATE            <=  1'b0;
                PE_SETREG           <=  16'd0;
                FIFO_ARRAY_CE       <=  1'b0;
                FIFO_INDI_CE        <=  16'd0;
                SHIFT_REG_CE        <=  1'b0;
                SHIFT_REG_STATE     <=  2'd0;
                FINAL_CAL_CE        <=  1'b0;
                
                PE_CE_GEN           <=  7'b1; 
                
                COUNTER_TRAINING    <=  32'd0;
                COUNTER_REG         <=  32'd0;
                STATE_SHIFTREG      <=  2'd0;
                STATE_RECURENT_CAL  <=   1'b0;
                RECCURENT_CAL       <=  1'b0;
            end
            5'b00001:               // training state
            begin
                COUNTER_TRAINING    <=   COUNTER_TRAINING + 1;
                
                if(COUNTER_TRAINING == NODES-1)
                begin
                    STATE = 5'b00000;
                    READ_DATA <= 1'b0;  
                end
               
                PE_CE_GEN           <=  PE_CE_GEN << 1;                
                PE_CE               <=  PE_CE + PE_CE_GEN ;
                PE_STATE            <=  1'b0;
                if(COUNTER_TRAINING == 0)
                    PE_SETREG           <=  16'b1;
                else
                    PE_SETREG           <=  PE_SETREG << 1;
                FIFO_ARRAY_CE       <=  1'b1;
                FIFO_INDI_CE        <=  PE_CE + PE_CE_GEN;
                SHIFT_REG_CE        <=  1'b0;
                SHIFT_REG_STATE     <=  2'd0;
                FINAL_CAL_CE        <=  1'b0;
                
            end
            5'b00010:
            begin
                COUNTER_REG         <=   COUNTER_REG + 1;;
                
                if(STATE_SHIFTREG == 2'b00)
                begin
                    PE_CE               <=  16'd0;
                    PE_STATE            <=  1'b0;
                    PE_SETREG           <=  16'd0;
                    FIFO_ARRAY_CE       <=  1'b1;
                    FIFO_INDI_CE        <=  16'b1111111111111111;
                    SHIFT_REG_CE        <=  1'b1;
                    SHIFT_REG_STATE     <=  STATE_SHIFTREG;
                    FINAL_CAL_CE        <=  1'b0;
                    
                    if(COUNTER_REG == NODES-1)
                    begin
                        STATE_SHIFTREG <= 2'b01;
                        COUNTER_REG    <= 32'd0;
                    end
                end
                else if(STATE_SHIFTREG == 2'b01)
                begin
                    PE_CE               <=  16'd0;
                    PE_STATE            <=  1'b0;
                    PE_SETREG           <=  16'd0;
                    FIFO_ARRAY_CE       <=  1'b1;
                    FIFO_INDI_CE        <=  16'd0;
                    SHIFT_REG_CE        <=  1'b1;
                    SHIFT_REG_STATE     <=  STATE_SHIFTREG;
                    FINAL_CAL_CE        <=  1'b0;
                    
                    if(COUNTER_REG == 32'd0)
                        STATE           <= 5'd0;
                        
                    WEIGHTS_SET         <=  1'b1;
                end                
            end
            5'b00011:           //pattern recognition state
            begin
                if(STATE_RECURENT_CAL)
                begin
                    PE_CE               <=  16'd0;
                    PE_STATE            <=  1'b0;
                    PE_SETREG           <=  16'd0;
                    FIFO_ARRAY_CE       <=  1'b0;
                    FIFO_INDI_CE        <=  16'd0;
                    SHIFT_REG_CE        <=  1'b0;
                    SHIFT_REG_STATE     <=  2'b00;
                    FINAL_CAL_CE        <=  1'b0;
                    STATE_RECURENT_CAL  <=  1'b0;
                end 
                else if(START_FINAL_CALC)
                begin
                    PE_CE               <=  16'd0;
                    PE_STATE            <=  1'b0;
                    PE_SETREG           <=  16'd0;
                    FIFO_ARRAY_CE       <=  1'b0;
                    FIFO_INDI_CE        <=  16'd0;
                    SHIFT_REG_CE        <=  1'b0;
                    SHIFT_REG_STATE     <=  2'b00;
                    FINAL_CAL_CE        <=  1'b1;
                    STATE_RECURENT_CAL  <=  1'b1;
                    RECCURENT_CAL       <=  1'b1;
                end
                else
                begin
                    PE_CE               <=  16'b1111111111111111;
                    PE_STATE            <=  1'b1;
                    PE_SETREG           <=  16'd0;
                    FIFO_ARRAY_CE       <=  1'b0;
                    FIFO_INDI_CE        <=  16'd0;
                    SHIFT_REG_CE        <=  1'b1;
                    SHIFT_REG_STATE     <=  2'b10;
                    FINAL_CAL_CE        <=  1'b0;
                end
                
                if(FINISH)
                    STATE = 5'd0;
                
            end
            default:
            begin
    
            end
            
        endcase        
    end
    
    
endmodule
