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


module TOP_MODULE_TEST;    
    parameter NODES = 16;
    parameter REG_SIZE = 6;
    reg CLK;
    reg [1:0] OPERATION;
    reg CE;
    reg DATA;
    wire [NODES-1:0] PATTERN;
    wire PATTEREN_VALID;
    wire READ_DATA;
    wire WEIGHTS_SET;
    
    integer DATA_FILE;
    integer ID_FILE;
    integer SCAN_FILE1;
    integer SCAN_FILE2;    
    integer i;
    initial 
    begin
        CLK = 1'b0;
        OPERATION = 2'b01;
        CE = 1'b1;
        DATA = 1'b0;
        DATA_FILE = $fopen("E:/ResearchProject/Simulation_files/TEST_TOP_MODULE.txt","r");
        ID_FILE = $fopen("E:/ResearchProject/Simulation_files/TEST_ID_MODULE.txt","r");
        i = 0;
        for(i=0;i<2000;i=i+1)
        begin
            #50
            CLK = 1'b1;
            if(READ_DATA)
                SCAN_FILE1 = $fscanf(DATA_FILE,"%b\n",DATA );
            
            if(i==33)
                OPERATION = 2'b10;   
               
            if(WEIGHTS_SET)
            begin
                OPERATION = 2'b11;  
            end
            
            
            #50
            CLK = 1'b0;
            if(OPERATION == 2'b11)
                SCAN_FILE2 =  $fscanf(ID_FILE,"%b\n",DATA );
        end
        
    end
    
    
    
    TOP_MODULE uut(
    .CLK(CLK),
    .OPERATION(OPERATION),
    .CE(CE),
    .DATA(DATA),
    .PATTERN(PATTERN),
    .PATTEREN_VALID(PATTEREN_VALID),
    .READ_DATA(READ_DATA),
    .WEIGHTS_SET(WEIGHTS_SET)
    );
    
    
endmodule
