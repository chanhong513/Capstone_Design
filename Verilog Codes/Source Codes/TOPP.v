`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/30 14:50:06
// Design Name: 
// Module Name: TOPP
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


module TOPP( 

    clk, rst,
    decision_o, valid_o

    );
    
    input clk, rst;
    output [3:0] decision_o;
    output valid_o;
    
    wire [7:0] in_data_o;
    wire valid;
    
    wire [3:0] decision;
    
   
    
    input_module input_module(

    clk, rst, in_data_o, valid
   
   );
   
   mnist_cnn mnist_cnn(
   clk, rst, in_data_o,
   
   decision, valid
);
    assign valid_o = valid;
    assign decision_o = decision;
   
endmodule
