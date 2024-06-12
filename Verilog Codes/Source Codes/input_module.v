`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 17:27:50
// Design Name: 
// Module Name: TOP
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


module input_module(

    clk, rst, in_data_o, valid_in
   
   );
    
    input clk,rst, valid_in;
    output [7:0]    in_data_o;
    
    reg                       rdptr;
    reg     signed [7:0]      in_data0[0:783]; // dataset '3'
    reg     signed [7:0]      in_data1[0:783]; // dataset '5'
    
    reg     signed [7:0]      in_data; // for output
    
    reg             [9:0]       i, i_d;
    
    initial begin
        $readmemh("in_data0.mif",in_data0);     
        $readmemh("in_data1.mif",in_data1);
        rdptr <= 1'b0;
    end
    
    
    
    always @(posedge clk) begin
        
        if(rst) begin
        
            i <= 'd0;
            i_d <= 'd0;
        
        end
        
        else begin
            if(valid_in) rdptr <= !rdptr;
        
            i <= i+1;
            i_d <= i;
        end
    end
    

    
        
    always @* begin
    
    if(rst) begin
        in_data = 'd0;
    end
    
    else begin
        case(rdptr)
            2'd0 : in_data = in_data0[i_d];         
            2'd1 : in_data = in_data1[i_d];
            default : in_data = in_data;
        endcase
    end
    
    end
    
    //Output Assignment   
    assign in_data_o = in_data;
        
     
        
        
    

endmodule
