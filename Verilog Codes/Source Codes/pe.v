`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/29 15:35:41
// Design Name: 
// Module Name: pe
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


module pe(
    clk, rst, en,
    in_data, in_weight, 
    out_data, out_weight, 
    buffer
    );
    input clk, rst, en;
    input signed [11:0] in_data;
    input signed [7:0] in_weight;
    output signed [11:0] out_data;
    output signed [7:0] out_weight;
    output reg signed [19:0] buffer;
    
    reg signed [11:0] data_buf;
    reg signed [7:0] weight_buf;
    
    always @ (posedge clk)
    begin 
        if(rst) begin
            buffer <= 20'b0;
            data_buf <= 12'b0;
            weight_buf <= 8'b0;
        end    
        else begin 
            if(en) begin
            
                data_buf <= in_data; // Delay input by one clock cycle
                weight_buf <= in_weight; // Delay input by one clock cycle
        
                buffer <= buffer + in_data * in_weight; // Use delayed inputs for calculation
            end
        end
    end
    assign out_data = data_buf;
    assign out_weight = weight_buf;
    
endmodule