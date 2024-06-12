module avg_pool #( parameter CONV_BIT = 12, HALF_WIDTH = 12, HALF_HEIGHT = 12, HALF_WIDTH_BIT = 4 )
(
    clk, rst,
    valid_in,
    conv_out_1, conv_out_2, conv_out_3,
   
    avg_value_1, avg_value_2, avg_value_3,
    valid_out
);

input clk, rst, valid_in; 
input signed [CONV_BIT - 1 : 0] conv_out_1, conv_out_2, conv_out_3;

output reg[CONV_BIT +1 : 0] avg_value_1, avg_value_2, avg_value_3; 
output reg valid_out;

//reg signed [CONV_BIT + 1 : 0] avg_med_1, avg_med_2, avg_med_3;
reg signed [CONV_BIT +1: 0] buffer_1 [0 : HALF_WIDTH - 1]; // Extend bit-width for sum
reg signed [CONV_BIT +1: 0] buffer_2 [0 : HALF_WIDTH - 1];
reg signed [CONV_BIT +1: 0] buffer_3 [0 : HALF_WIDTH - 1];

reg [HALF_WIDTH_BIT - 1 : 0] pcount;
reg state; // 0 : p0,p1 // 1 : p2,p3, out
reg flag; // 0 : input // 1 : Compare, Average

always @ (posedge clk) begin
    if(rst) begin
        state <= 0;
        pcount <= 0;
        valid_out <= 0;
        flag <= 0;
    end
    else begin
        if(valid_in == 1) begin
            flag <= ~flag;
            if(flag == 1) begin
                pcount <= pcount + 1;
                if(pcount == HALF_WIDTH - 1) begin
                    state <= ~state;
                    pcount <= 0;
                end
            end
            
            if(state == 0) begin
                if(flag == 0) begin
                    valid_out <= 0;
                    buffer_1[pcount] <= conv_out_1;
                    buffer_2[pcount] <= conv_out_2;
                    buffer_3[pcount] <= conv_out_3;
                    
                end
                else begin
                    valid_out <= 0;
                    buffer_1[pcount] <= buffer_1[pcount] + conv_out_1;
                    buffer_2[pcount] <= buffer_2[pcount] + conv_out_2;
                    buffer_3[pcount] <= buffer_3[pcount] + conv_out_3;
                end
            end
            else begin
                if(flag == 0) begin
                    valid_out <= 0;
                    buffer_1[pcount] <= buffer_1[pcount] + conv_out_1;
                    buffer_2[pcount] <= buffer_2[pcount] + conv_out_2;
                    buffer_3[pcount] <= buffer_3[pcount] + conv_out_3;
                end
                else begin
                    valid_out <= 1;
                    avg_value_1 <= buffer_1[pcount] + conv_out_1;
                    avg_value_2 <= buffer_2[pcount] + conv_out_2;
                    avg_value_3 <= buffer_3[pcount] + conv_out_3;

                end
            end
        end
        else begin
            valid_out <= 0;
        end
    end
end

endmodule

