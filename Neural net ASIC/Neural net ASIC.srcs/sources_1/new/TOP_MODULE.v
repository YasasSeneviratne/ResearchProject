`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
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


module TOP_MODULE#(
    parameter NODES = 16,
    parameter REG_SIZE = 6
    )(
    CLK,
    OPERATION,                          //idle 00 , training state 01, move to memory 10, rec pattern 11
    CE,
    DATA,
    PATTERN,
    PATTEREN_VALID,
    READ_DATA,
    WEIGHTS_SET
    );
    
    
    input CLK;
    input [1:0]  OPERATION;
    input CE;
    input DATA;
    output  [NODES-1:0] PATTERN;
    output PATTEREN_VALID;
    output READ_DATA;
    output WEIGHTS_SET;
    
    
    wire  [NODES - 1:0] PE_CE;
    wire                PE_STATE;
    wire  [NODES - 1:0] PE_SETREG;
    wire                FIFO_ARRAY_CE;
    wire  [NODES - 1:0] FIFO_INDI_CE;
    wire                SHIFT_REG_CE;
    wire  [     1   :0] SHIFT_REG_STATE;
    wire                FINAL_CAL_CE;
    reg   [NODES - 1:0] COMP_IN;
    wire                RECCURENT_CAL;
    reg                 DATA_FINAL;
    
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_0;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_1;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_2;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_3;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_4;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_5;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_6;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_7;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_8;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_9;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_10;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_11;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_12;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_13;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_14;
    wire  [REG_SIZE - 1:0] PE_TO_FIFO_15;
    
    wire  [REG_SIZE - 1:0] FIFO_OUT_0;
    wire  [REG_SIZE - 1:0] FIFO_OUT_1;
    wire  [REG_SIZE - 1:0] FIFO_OUT_2;
    wire  [REG_SIZE - 1:0] FIFO_OUT_3;
    wire  [REG_SIZE - 1:0] FIFO_OUT_4;
    wire  [REG_SIZE - 1:0] FIFO_OUT_5;
    wire  [REG_SIZE - 1:0] FIFO_OUT_6;
    wire  [REG_SIZE - 1:0] FIFO_OUT_7;
    wire  [REG_SIZE - 1:0] FIFO_OUT_8;
    wire  [REG_SIZE - 1:0] FIFO_OUT_9;
    wire  [REG_SIZE - 1:0] FIFO_OUT_10;
    wire  [REG_SIZE - 1:0] FIFO_OUT_11;
    wire  [REG_SIZE - 1:0] FIFO_OUT_12;
    wire  [REG_SIZE - 1:0] FIFO_OUT_13;
    wire  [REG_SIZE - 1:0] FIFO_OUT_14;
    wire  [REG_SIZE - 1:0] FIFO_OUT_15;      
       
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_0;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_1;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_2;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_3;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_4;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_5;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_6;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_7;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_8;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_9;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_10;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_11;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_12;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_13;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_14;
    wire  [REG_SIZE - 1:0] REG_ARRAY_TO_PE_15;
    
    wire  [REG_SIZE - 1:0] PE_TO_REG_0;
    wire  [REG_SIZE - 1:0] PE_TO_REG_1;
    wire  [REG_SIZE - 1:0] PE_TO_REG_2;
    wire  [REG_SIZE - 1:0] PE_TO_REG_3;
    wire  [REG_SIZE - 1:0] PE_TO_REG_4;
    wire  [REG_SIZE - 1:0] PE_TO_REG_5;
    wire  [REG_SIZE - 1:0] PE_TO_REG_6;
    wire  [REG_SIZE - 1:0] PE_TO_REG_7;
    wire  [REG_SIZE - 1:0] PE_TO_REG_8;
    wire  [REG_SIZE - 1:0] PE_TO_REG_9;
    wire  [REG_SIZE - 1:0] PE_TO_REG_10;
    wire  [REG_SIZE - 1:0] PE_TO_REG_11;
    wire  [REG_SIZE - 1:0] PE_TO_REG_12;
    wire  [REG_SIZE - 1:0] PE_TO_REG_13;
    wire  [REG_SIZE - 1:0] PE_TO_REG_14;
    wire  [REG_SIZE - 1:0] PE_TO_REG_15;
    
    reg   [REG_SIZE - 1:0] REG [NODES-1:0];
    reg   [NODES    - 1:0] RECCURRENT_PATTERN;
    integer                COUNTER;
    reg                    START_FINAL_CALC;
    reg   [NODES    - 1:0] FINAL_PATTERN;
    
    assign PATTERN = (PATTEREN_VALID)? FINAL_PATTERN : 7'd0;
    initial
    begin
        COUNTER = 32'd0;
        START_FINAL_CALC = 1'b0;
        COMP_IN  = 7'd0;
        
        REG[0]  = 6'd0;
        REG[1]  = 6'd0;
        REG[2]  = 6'd0;
        REG[3]  = 6'd0;
        REG[4]  = 6'd0;
        REG[5]  = 6'd0;
        REG[6]  = 6'd0;
        REG[7]  = 6'd0;
        REG[8]  = 6'd0;
        REG[9]  = 6'd0;
        REG[10]  = 6'd0;
        REG[11]  = 6'd0;
        REG[12]  = 6'd0;
        REG[13]  = 6'd0;
        REG[14]  = 6'd0;
        REG[15]  = 6'd0;
        
        FINAL_PATTERN = 7'd0;
    end
    //processing elements
    
    PE PE0(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_0),
        .IN_FIFO(FIFO_OUT_0),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[0]),
        .CLK(CLK),
        .IN_REG(REG[0]),
        .OP_REG(PE_TO_REG_0),
        .OP_FIFO(PE_TO_FIFO_0),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[0]));
    
    PE PE1(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_1),
        .IN_FIFO(FIFO_OUT_1),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[1]),
        .CLK(CLK),
        .IN_REG(REG[1]),
        .OP_REG(PE_TO_REG_1),
        .OP_FIFO(PE_TO_FIFO_1),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[1]));
    
    PE PE2(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_2),
        .IN_FIFO(FIFO_OUT_2),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[2]),
        .CLK(CLK),
        .IN_REG(REG[2]),
        .OP_REG(PE_TO_REG_2),
        .OP_FIFO(PE_TO_FIFO_2),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[2]));
        
    PE PE3(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_3),
        .IN_FIFO(FIFO_OUT_3),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[3]),
        .CLK(CLK),
        .IN_REG(REG[3]),
        .OP_REG(PE_TO_REG_3),
        .OP_FIFO(PE_TO_FIFO_3),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[3]));
    
    PE PE4(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_4),
        .IN_FIFO(FIFO_OUT_4),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[4]),
        .CLK(CLK),
        .IN_REG(REG[4]),
        .OP_REG(PE_TO_REG_4),
        .OP_FIFO(PE_TO_FIFO_4),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[4]));
    
    PE PE5(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_5),
        .IN_FIFO(FIFO_OUT_5),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[5]),
        .CLK(CLK),
        .IN_REG(REG[5]),
        .OP_REG(PE_TO_REG_5),
        .OP_FIFO(PE_TO_FIFO_5),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[5]));
    
    PE PE6(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_6),
        .IN_FIFO(FIFO_OUT_6),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[6]),
        .CLK(CLK),
        .IN_REG(REG[6]),
        .OP_REG(PE_TO_REG_6),
        .OP_FIFO(PE_TO_FIFO_6),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[6]));
        
    PE PE7(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_7),
        .IN_FIFO(FIFO_OUT_7),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[7]),
        .CLK(CLK),
        .IN_REG(REG[7]),
        .OP_REG(PE_TO_REG_7),
        .OP_FIFO(PE_TO_FIFO_7),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[7]));
    
    PE PE8(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_8),
        .IN_FIFO(FIFO_OUT_8),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[8]),
        .CLK(CLK),
        .IN_REG(REG[8]),
        .OP_REG(PE_TO_REG_8),
        .OP_FIFO(PE_TO_FIFO_8),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[8]));
    
    PE PE9(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_9),
        .IN_FIFO(FIFO_OUT_9),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[9]),
        .CLK(CLK),
        .IN_REG(REG[9]),
        .OP_REG(PE_TO_REG_9),
        .OP_FIFO(PE_TO_FIFO_9),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[9]));
     
     PE PE10(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_10),
        .IN_FIFO(FIFO_OUT_10),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[10]),
        .CLK(CLK),
        .IN_REG(REG[10]),
        .OP_REG(PE_TO_REG_10),
        .OP_FIFO(PE_TO_FIFO_10),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[10]));
        
     PE PE11(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_11),
        .IN_FIFO(FIFO_OUT_11),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[11]),
        .CLK(CLK),
        .IN_REG(REG[11]),
        .OP_REG(PE_TO_REG_11),
        .OP_FIFO(PE_TO_FIFO_11),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[11]));
        
     PE PE12(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_12),
        .IN_FIFO(FIFO_OUT_12),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[12]),
        .CLK(CLK),
        .IN_REG(REG[12]),
        .OP_REG(PE_TO_REG_12),
        .OP_FIFO(PE_TO_FIFO_12),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[12]));
        
     PE PE13(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_13),
        .IN_FIFO(FIFO_OUT_13),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[13]),
        .CLK(CLK),
        .IN_REG(REG[13]),
        .OP_REG(PE_TO_REG_13),
        .OP_FIFO(PE_TO_FIFO_13),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[13]));
     
     PE PE14(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_14),
        .IN_FIFO(FIFO_OUT_14),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[14]),
        .CLK(CLK),
        .IN_REG(REG[14]),
        .OP_REG(PE_TO_REG_14),
        .OP_FIFO(PE_TO_FIFO_14),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[14]));
        
     PE PE15(
        .IN_SHIFT_REG(REG_ARRAY_TO_PE_15),
        .IN_FIFO(FIFO_OUT_15),
        .IN_DATA(DATA_FINAL),
        .CE(PE_CE[15]),
        .CLK(CLK),
        .IN_REG(REG[15]),
        .OP_REG(PE_TO_REG_15),
        .OP_FIFO(PE_TO_FIFO_15),
        .CNT_STATE(PE_STATE),
        .CNT_SETREG(PE_SETREG[15]));
    //Shift register array
    
    SHIFT_REG SHIFT_REG_ARRAY(
        .DATA_IN0(FIFO_OUT_0), //from FIFO 1
        .DATA_IN1(FIFO_OUT_1), //vica versa
        .DATA_IN2(FIFO_OUT_2),
        .DATA_IN3(FIFO_OUT_3),
        .DATA_IN4(FIFO_OUT_4),
        .DATA_IN5(FIFO_OUT_5),
        .DATA_IN6(FIFO_OUT_6),
        .DATA_IN7(FIFO_OUT_7),
        .DATA_IN8(FIFO_OUT_8),
        .DATA_IN9(FIFO_OUT_9),
        .DATA_IN10(FIFO_OUT_10),
        .DATA_IN11(FIFO_OUT_11),
        .DATA_IN12(FIFO_OUT_12),
        .DATA_IN13(FIFO_OUT_13),
        .DATA_IN14(FIFO_OUT_14),
        
     //   DATA_IN6,
        
        .DATA_OUT0(REG_ARRAY_TO_PE_0),
        .DATA_OUT1(REG_ARRAY_TO_PE_1),
        .DATA_OUT2(REG_ARRAY_TO_PE_2),
        .DATA_OUT3(REG_ARRAY_TO_PE_3),
        .DATA_OUT4(REG_ARRAY_TO_PE_4),
        .DATA_OUT5(REG_ARRAY_TO_PE_5),
        .DATA_OUT6(REG_ARRAY_TO_PE_6),
        .DATA_OUT7(REG_ARRAY_TO_PE_7),
        .DATA_OUT8(REG_ARRAY_TO_PE_8),
        .DATA_OUT9(REG_ARRAY_TO_PE_9),
        .DATA_OUT10(REG_ARRAY_TO_PE_10),
        .DATA_OUT11(REG_ARRAY_TO_PE_11),
        .DATA_OUT12(REG_ARRAY_TO_PE_12),
        .DATA_OUT13(REG_ARRAY_TO_PE_13),
        .DATA_OUT14(REG_ARRAY_TO_PE_14),
        .DATA_OUT15(REG_ARRAY_TO_PE_15),
        
        .CNT_STATE(SHIFT_REG_STATE),
        .CE(SHIFT_REG_CE),
        .CLK(CLK)
        );
    
    //FOFO array
    
    FIFO_ARRAY FIFO_ARRAY(
        .FIFO_IN0(PE_TO_FIFO_0),
        .FIFO_IN1(PE_TO_FIFO_1),
        .FIFO_IN2(PE_TO_FIFO_2),
        .FIFO_IN3(PE_TO_FIFO_3),
        .FIFO_IN4(PE_TO_FIFO_4),
        .FIFO_IN5(PE_TO_FIFO_5),
        .FIFO_IN6(PE_TO_FIFO_6),
        .FIFO_IN7(PE_TO_FIFO_7),
        .FIFO_IN8(PE_TO_FIFO_8),
        .FIFO_IN9(PE_TO_FIFO_9),
        .FIFO_IN10(PE_TO_FIFO_10),
        .FIFO_IN11(PE_TO_FIFO_11),
        .FIFO_IN12(PE_TO_FIFO_12),
        .FIFO_IN13(PE_TO_FIFO_13),
        .FIFO_IN14(PE_TO_FIFO_14),
        
        .FIFO_OUT0(FIFO_OUT_0),
        .FIFO_OUT1(FIFO_OUT_1),
        .FIFO_OUT2(FIFO_OUT_2),
        .FIFO_OUT3(FIFO_OUT_3),
        .FIFO_OUT4(FIFO_OUT_4),
        .FIFO_OUT5(FIFO_OUT_5),
        .FIFO_OUT6(FIFO_OUT_6),
        .FIFO_OUT7(FIFO_OUT_7),
        .FIFO_OUT8(FIFO_OUT_8),
        .FIFO_OUT9(FIFO_OUT_9),
        .FIFO_OUT10(FIFO_OUT_10),
        .FIFO_OUT11(FIFO_OUT_11),
        .FIFO_OUT12(FIFO_OUT_12),
        .FIFO_OUT13(FIFO_OUT_13),
        .FIFO_OUT14(FIFO_OUT_14),
        
        .CE_FIFO(FIFO_INDI_CE),
        .CE(FIFO_ARRAY_CE),
        .CLK(CLK)
        );
    wire STATE_RECURENT_CAL;
    CONTROLLER CONTROLLER(
        .CLK(CLK),
        .FINISH(PATTEREN_VALID),
        .OPERATION(OPERATION),             //training (01), find pattern(10) or idle(00)
        .START_FINAL_CALC(START_FINAL_CALC),
        .PE_CE(PE_CE),
        .PE_STATE(PE_STATE),              //training (0), find pattern(1)  can be fullt dissbled by CE 
        .PE_SETREG(PE_SETREG),
        .FIFO_ARRAY_CE(FIFO_ARRAY_CE),
        .FIFO_INDI_CE(FIFO_INDI_CE),
        .SHIFT_REG_CE(SHIFT_REG_CE),
        .SHIFT_REG_STATE(SHIFT_REG_STATE),
        .FINAL_CAL_CE(FINAL_CAL_CE),
        .READ_DATA(READ_DATA),
        .WEIGHTS_SET(WEIGHTS_SET),
        .RECCURENT_CAL(RECCURENT_CAL),
        .STATE_RECURENT_CAL(STATE_RECURENT_CAL)
    );
    
    FINAL_CALCULATOR FINAL_CALCULATOR(
    .COMP_IN(FINAL_PATTERN),     //comparator outputs
    .CLK(CLK),
    .CE(FINAL_CAL_CE),
 //   .PATTERN(PATTERN),
    .CNT_FINISH(PATTEREN_VALID)
    ); 
    
    integer i;
    
    always@(*)
    begin
    
        
        if(OPERATION ==2'b11 && START_FINAL_CALC)
        begin
            for(i=0; i<NODES; i=i+1)
            begin
                if($signed(REG[i])> $signed(6'd0))
                    COMP_IN[i] = 1'b1;
                else
                    COMP_IN[i] = 1'b0;
            end
        end
        else
            COMP_IN = 7'd0;
            
        if(RECCURENT_CAL)
            DATA_FINAL = RECCURRENT_PATTERN[0];
        else
            DATA_FINAL = DATA;
    end
//    always@(posedge START_FINAL_CALC)
//    begin
//        RECCURRENT_PATTERN <= COMP_IN;
//    end

    
    
    always@(posedge CLK)
    begin
        if(START_FINAL_CALC)
        begin
            RECCURRENT_PATTERN <= COMP_IN;
            FINAL_PATTERN      <= COMP_IN;
        end        
        else if(RECCURENT_CAL && SHIFT_REG_CE)
            RECCURRENT_PATTERN <= RECCURRENT_PATTERN >> 1;
            
        if(OPERATION == 2'b11)
        begin
        
            if(COUNTER == NODES || START_FINAL_CALC)
            begin
                COUNTER <= 32'd0;                
            end    
            else
            begin
                COUNTER <= COUNTER + 1;                
            end
            
            if(COUNTER == NODES)
            begin               
               START_FINAL_CALC <= 1'b1;
            end    
            else
            begin               
               START_FINAL_CALC <= 1'b0;
            end
            
            if(PE_CE[0])
            begin
                REG[0] <= PE_TO_REG_0;
                REG[1] <= PE_TO_REG_1;
                REG[2] <= PE_TO_REG_2;
                REG[3] <= PE_TO_REG_3;
                REG[4] <= PE_TO_REG_4;
                REG[5] <= PE_TO_REG_5;
                REG[6] <= PE_TO_REG_6;
                REG[7] <= PE_TO_REG_7;
                REG[8] <= PE_TO_REG_8;
                REG[9] <= PE_TO_REG_9;
                REG[10] <= PE_TO_REG_10;
                REG[11] <= PE_TO_REG_11;
                REG[12] <= PE_TO_REG_12;
                REG[13] <= PE_TO_REG_13;
                REG[14] <= PE_TO_REG_14;
                REG[15] <= PE_TO_REG_15;
            end
            if(START_FINAL_CALC)
            begin
            
                for(i=0;i<16;i=i+1)
                begin
//                    if($signed(REG[i]) > $signed(6'd0))
//                        REG[i] <= 6'd1;
//                    else
                        REG[i] <= 6'd0;
                end
//                REG[0] <= 6'd0;
//                REG[1] <= 6'd0;
//                REG[2] <= 6'd0;
//                REG[3] <= 6'd0;
//                REG[4] <= 6'd0;
//                REG[5] <= 6'd0;
//                REG[6] <= 6'd0;
//                REG[7] <= 6'd0;
//                REG[8] <= 6'd0;
//                REG[9] <= 6'd0;
//                REG[10] <= 6'd0;
//                REG[11] <= 6'd0;
//                REG[12] <= 6'd0;
//                REG[13] <= 6'd0;
//                REG[14] <= 6'd0;
//                REG[15] <= 6'd0;
            end
        end
    
    end
    
endmodule
