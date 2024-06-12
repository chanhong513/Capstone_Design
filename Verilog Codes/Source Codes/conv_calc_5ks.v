module conv_calc_5ks(
	valid_in, clk, rst,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, 

	conv_out_1, conv_out_2, conv_out_3,
	valid_out
);

input valid_in;
input clk;
input rst;

input [7:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
			out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
			out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
			out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
			out_data_20, out_data_21, out_data_22, out_data_23;

// calc_out / 256 = conv_out
output reg signed [11:0] conv_out_1;
output reg signed [11:0] conv_out_2;
output reg signed [11:0] conv_out_3;

output reg valid_out;

wire signed [19:0] out_wire_1[0:23];
wire signed [19:0] out_wire_2[0:23];
wire signed [19:0] out_wire_3[0:23];

reg signed [19:0] out_buf_1[0:23];
reg signed [19:0] out_buf_2[0:23];
reg signed [19:0] out_buf_3[0:23];

reg signed [7:0] weight_1 [0:24];
reg signed [7:0] weight_2 [0:24];
reg signed [7:0] weight_3 [0:24];

reg signed [7:0] win_buf[1:3];
reg signed [11:0] din_buf[0:23];

reg [4:0] count;
reg en;
reg sys_rst;
reg [4:0]line_count;

initial begin

$readmemh("conv1_weight_1.mif", weight_1);
$readmemh("conv1_weight_2.mif", weight_2);
$readmemh("conv1_weight_3.mif", weight_3);
end

// Unsigned to Signed


always @ (posedge clk) begin
        if (count <= 24) begin
        din_buf[0] <= {4'd0, out_data_0};
        din_buf[1] <= {4'd0, out_data_1};
        din_buf[2] <= {4'd0, out_data_2};
        din_buf[3] <= {4'd0, out_data_3};
        din_buf[4] <= {4'd0, out_data_4};
        din_buf[5] <= {4'd0, out_data_5};
        din_buf[6] <= {4'd0, out_data_6};
        din_buf[7] <= {4'd0, out_data_7};
        din_buf[8] <= {4'd0, out_data_8};
        din_buf[9] <= {4'd0, out_data_9};
        din_buf[10] <= {4'd0, out_data_10};
        din_buf[11] <= {4'd0, out_data_11};
        din_buf[12] <= {4'd0, out_data_12};
        din_buf[13] <= {4'd0, out_data_13};
        din_buf[14] <= {4'd0, out_data_14};
        din_buf[15] <= {4'd0, out_data_15};
        din_buf[16] <= {4'd0, out_data_16};
        din_buf[17] <= {4'd0, out_data_17};
        din_buf[18] <= {4'd0, out_data_18};
        din_buf[19] <= {4'd0, out_data_19};
        din_buf[20] <= {4'd0, out_data_20};
        din_buf[21] <= {4'd0, out_data_21};
        din_buf[22] <= {4'd0, out_data_22};
        din_buf[23] <= {4'd0, out_data_23};
        end
        else begin
        din_buf[0] <= 0;
        din_buf[1] <= 0;
        din_buf[2] <= 0;
        din_buf[3] <= 0;
        din_buf[4] <= 0;
        din_buf[5] <= 0;
        din_buf[6] <= 0;
        din_buf[7] <= 0;
        din_buf[8] <= 0;
        din_buf[9] <= 0;
        din_buf[10] <= 0;
        din_buf[11] <= 0;
        din_buf[12] <= 0;
        din_buf[13] <= 0;
        din_buf[14] <= 0;
        din_buf[15] <= 0;
        din_buf[16] <= 0;
        din_buf[17] <= 0;
        din_buf[18] <= 0;
        din_buf[19] <= 0;
        din_buf[20] <= 0;
        din_buf[21] <= 0;
        din_buf[22] <= 0;
        din_buf[23] <= 0;
        end
        
    if(rst) begin
        count <= 0;
        en <= 0;
        sys_rst <= 1;
        line_count <= 0;
        valid_out <= 0;
    end
    else begin
        
        
        case(count)
            5'd0: begin
                sys_rst <= 0;
                if(!valid_in && line_count == 24) begin
                    en <= 0;
                    //valid_out <= 1;
                    count <= count + 1;
                end
                else if(!valid_in) begin
                    en <= 0;
                    valid_out <= 0;
                    win_buf[1] <= 0;
                    win_buf[2] <= 0;
                    win_buf[3] <= 0;
                end
                else begin
                    en <= 1;
                    //sys_rst <= 1;
                    win_buf[1] <= weight_1[0];
                    win_buf[2] <= weight_2[0];
                    win_buf[3] <= weight_3[0];
                    count <= count  + 1;
                end
                if(line_count > 0) begin
                out_buf_1[0] <= out_wire_1[0]; out_buf_2[0] <= out_wire_2[0]; out_buf_3[0] <= out_wire_3[0];
                out_buf_1[1] <= out_wire_1[1]; out_buf_2[1] <= out_wire_2[1]; out_buf_3[1] <= out_wire_3[1];
                out_buf_1[2] <= out_wire_1[2]; out_buf_2[2] <= out_wire_2[2]; out_buf_3[2] <= out_wire_3[2];
                out_buf_1[3] <= out_wire_1[3]; out_buf_2[3] <= out_wire_2[3]; out_buf_3[3] <= out_wire_3[3];
                out_buf_1[4] <= out_wire_1[4]; out_buf_2[4] <= out_wire_2[4]; out_buf_3[4] <= out_wire_3[4];
                out_buf_1[5] <= out_wire_1[5]; out_buf_2[5] <= out_wire_2[5]; out_buf_3[5] <= out_wire_3[5];
                
                out_buf_1[6] <= out_wire_1[6]; out_buf_2[6] <= out_wire_2[6]; out_buf_3[6] <= out_wire_3[6];
                out_buf_1[7] <= out_wire_1[7]; out_buf_2[7] <= out_wire_2[7]; out_buf_3[7] <= out_wire_3[7];
                out_buf_1[8] <= out_wire_1[8]; out_buf_2[8] <= out_wire_2[8]; out_buf_3[8] <= out_wire_3[8];
                out_buf_1[9] <= out_wire_1[9]; out_buf_2[9] <= out_wire_2[9]; out_buf_3[9] <= out_wire_3[9];
                out_buf_1[10] <= out_wire_1[10]; out_buf_2[10] <= out_wire_2[10]; out_buf_3[10] <= out_wire_3[10];
                out_buf_1[11] <= out_wire_1[11]; out_buf_2[11] <= out_wire_2[11]; out_buf_3[11] <= out_wire_3[11];
                
                out_buf_1[12] <= out_wire_1[12]; out_buf_2[12] <= out_wire_2[12]; out_buf_3[12] <= out_wire_3[12];
                out_buf_1[13] <= out_wire_1[13]; out_buf_2[13] <= out_wire_2[13]; out_buf_3[13] <= out_wire_3[13];
                out_buf_1[14] <= out_wire_1[14]; out_buf_2[14] <= out_wire_2[14]; out_buf_3[14] <= out_wire_3[14];
                out_buf_1[15] <= out_wire_1[15]; out_buf_2[15] <= out_wire_2[15]; out_buf_3[15] <= out_wire_3[15];
                out_buf_1[16] <= out_wire_1[16]; out_buf_2[16] <= out_wire_2[16]; out_buf_3[16] <= out_wire_3[16];
                out_buf_1[17] <= out_wire_1[17]; out_buf_2[17] <= out_wire_2[17]; out_buf_3[17] <= out_wire_3[17];
                
                out_buf_1[18] <= out_wire_1[18]; out_buf_2[18] <= out_wire_2[18]; out_buf_3[18] <= out_wire_3[18];
                out_buf_1[19] <= out_wire_1[19]; out_buf_2[19] <= out_wire_2[19]; out_buf_3[19] <= out_wire_3[19];
                out_buf_1[20] <= out_wire_1[20]; out_buf_2[20] <= out_wire_2[20]; out_buf_3[20] <= out_wire_3[20];
                out_buf_1[21] <= out_wire_1[21]; out_buf_2[21] <= out_wire_2[21]; out_buf_3[21] <= out_wire_3[21];
                out_buf_1[22] <= out_wire_1[22]; out_buf_2[22] <= out_wire_2[22]; out_buf_3[22] <= out_wire_3[22];
                out_buf_1[23] <= out_wire_1[23]; out_buf_2[23] <= out_wire_2[23]; out_buf_3[23] <= out_wire_3[23];
                    //valid_out <= 1;
                    //conv_out_1 <= out_buf_1[0][19:8];
                    //conv_out_2 <= out_buf_2[0][19:8];
                    //conv_out_3 <= out_buf_3[0][19:8];
                end
            end
            5'd1: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[1];
                win_buf[2] <= weight_2[1];
                win_buf[3] <= weight_3[1];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    valid_out <= 1;
                    conv_out_1 <= out_buf_1[0][19:8];
                    conv_out_2 <= out_buf_2[0][19:8];
                    conv_out_3 <= out_buf_3[0][19:8];
                end
            end
            5'd2: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[2];
                win_buf[2] <= weight_2[2];
                win_buf[3] <= weight_3[2];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[1][19:8];
                    conv_out_2 <= out_buf_2[1][19:8];
                    conv_out_3 <= out_buf_3[1][19:8];
                end
            end
            5'd3: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[3];
                win_buf[2] <= weight_2[3];
                win_buf[3] <= weight_3[3];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[2][19:8];
                    conv_out_2 <= out_buf_2[2][19:8];
                    conv_out_3 <= out_buf_3[2][19:8];
                end
            end
            5'd4: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[4];
                win_buf[2] <= weight_2[4];
                win_buf[3] <= weight_3[4];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[3][19:8];
                    conv_out_2 <= out_buf_2[3][19:8];
                    conv_out_3 <= out_buf_3[3][19:8];
                end
            end
            5'd5: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[5];
                win_buf[2] <= weight_2[5];
                win_buf[3] <= weight_3[5];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[4][19:8];
                    conv_out_2 <= out_buf_2[4][19:8];
                    conv_out_3 <= out_buf_3[4][19:8];
                end
            end
             5'd6: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[6];
                win_buf[2] <= weight_2[6];
                win_buf[3] <= weight_3[6];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[5][19:8];
                    conv_out_2 <= out_buf_2[5][19:8];
                    conv_out_3 <= out_buf_3[5][19:8];
                end
            end
            5'd7: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[7];
                win_buf[2] <= weight_2[7];
                win_buf[3] <= weight_3[7];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[6][19:8];
                    conv_out_2 <= out_buf_2[6][19:8];
                    conv_out_3 <= out_buf_3[6][19:8];
                end
            end
            5'd8: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[8];
                win_buf[2] <= weight_2[8];
                win_buf[3] <= weight_3[8];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[7][19:8];
                    conv_out_2 <= out_buf_2[7][19:8];
                    conv_out_3 <= out_buf_3[7][19:8];
                end
            end
            5'd9: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[9];
                win_buf[2] <= weight_2[9];
                win_buf[3] <= weight_3[9];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[8][19:8];
                    conv_out_2 <= out_buf_2[8][19:8];
                    conv_out_3 <= out_buf_3[8][19:8];
                end
            end
            5'd10: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[10];
                win_buf[2] <= weight_2[10];
                win_buf[3] <= weight_3[10];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[9][19:8];
                    conv_out_2 <= out_buf_2[9][19:8];
                    conv_out_3 <= out_buf_3[9][19:8];
                end
            end
            5'd11: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[11];
                win_buf[2] <= weight_2[11];
                win_buf[3] <= weight_3[11];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[10][19:8];
                    conv_out_2 <= out_buf_2[10][19:8];
                    conv_out_3 <= out_buf_3[10][19:8];
                end
            end
            5'd12: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[12];
                win_buf[2] <= weight_2[12];
                win_buf[3] <= weight_3[12];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[11][19:8];
                    conv_out_2 <= out_buf_2[11][19:8];
                    conv_out_3 <= out_buf_3[11][19:8];
                end
            end
            5'd13: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[13];
                win_buf[2] <= weight_2[13];
                win_buf[3] <= weight_3[13];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[12][19:8];
                    conv_out_2 <= out_buf_2[12][19:8];
                    conv_out_3 <= out_buf_3[12][19:8];
                end
            end
            5'd14: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[14];
                win_buf[2] <= weight_2[14];
                win_buf[3] <= weight_3[14];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[13][19:8];
                    conv_out_2 <= out_buf_2[13][19:8];
                    conv_out_3 <= out_buf_3[13][19:8];
                end
            end
            5'd15: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[15];
                win_buf[2] <= weight_2[15];
                win_buf[3] <= weight_3[15];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[14][19:8];
                    conv_out_2 <= out_buf_2[14][19:8];
                    conv_out_3 <= out_buf_3[14][19:8];
                end
            end
             5'd16: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[16];
                win_buf[2] <= weight_2[16];
                win_buf[3] <= weight_3[16];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[15][19:8];
                    conv_out_2 <= out_buf_2[15][19:8];
                    conv_out_3 <= out_buf_3[15][19:8];
                end
            end
            5'd17: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[17];
                win_buf[2] <= weight_2[17];
                win_buf[3] <= weight_3[17];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[16][19:8];
                    conv_out_2 <= out_buf_2[16][19:8];
                    conv_out_3 <= out_buf_3[16][19:8];
                end
            end
            5'd18: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[18];
                win_buf[2] <= weight_2[18];
                win_buf[3] <= weight_3[18];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[17][19:8];
                    conv_out_2 <= out_buf_2[17][19:8];
                    conv_out_3 <= out_buf_3[17][19:8];
                end
            end
            5'd19: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[19];
                win_buf[2] <= weight_2[19];
                win_buf[3] <= weight_3[19];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[18][19:8];
                    conv_out_2 <= out_buf_2[18][19:8];
                    conv_out_3 <= out_buf_3[18][19:8];
                end
            end
            5'd20: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[20];
                win_buf[2] <= weight_2[20];
                win_buf[3] <= weight_3[20];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[19][19:8];
                    conv_out_2 <= out_buf_2[19][19:8];
                    conv_out_3 <= out_buf_3[19][19:8];
                end
            end
            5'd21: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[21];
                win_buf[2] <= weight_2[21];
                win_buf[3] <= weight_3[21];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[20][19:8];
                    conv_out_2 <= out_buf_2[20][19:8];
                    conv_out_3 <= out_buf_3[20][19:8];
                end
            end
            5'd22: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[22];
                win_buf[2] <= weight_2[22];
                win_buf[3] <= weight_3[22];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[21][19:8];
                    conv_out_2 <= out_buf_2[21][19:8];
                    conv_out_3 <= out_buf_3[21][19:8];
                end
            end
            5'd23: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[23];
                win_buf[2] <= weight_2[23];
                win_buf[3] <= weight_3[23];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[22][19:8];
                    conv_out_2 <= out_buf_2[22][19:8];
                    conv_out_3 <= out_buf_3[22][19:8];
                end
                //valid_out <= 0;
            end
            5'd24: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[24];
                win_buf[2] <= weight_2[24];
                win_buf[3] <= weight_3[24];
                count <= count  + 1;
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[23][19:8];
                    conv_out_2 <= out_buf_2[23][19:8];
                    conv_out_3 <= out_buf_3[23][19:8];
                end
                //valid_out <= 0;
            end
            5'd25: begin
                sys_rst <= 0;
                win_buf[1] <= 0;
                win_buf[2] <= 0;
                win_buf[3] <= 0;
                count <= count  + 1;
                valid_out <= 0;
            end
            5'd26: begin
                sys_rst <= 0;
                win_buf[1] <= 0;
                win_buf[2] <= 0;
                win_buf[3] <= 0;
                count <= count + 1;
               
            end
            5'd27: begin
                sys_rst <= 1;
                win_buf[1] <= 0;
                win_buf[2] <= 0;
                win_buf[3] <= 0;
                count <= 0;
                if (line_count == 24) begin
                line_count <= 0;
                end
                else begin
                line_count <= line_count + 1;
                //valid_out <= 1;
                end
                
                out_buf_1[0] <= out_wire_1[0]; out_buf_2[0] <= out_wire_2[0]; out_buf_3[0] <= out_wire_3[0];
                out_buf_1[1] <= out_wire_1[1]; out_buf_2[1] <= out_wire_2[1]; out_buf_3[1] <= out_wire_3[1];
                out_buf_1[2] <= out_wire_1[2]; out_buf_2[2] <= out_wire_2[2]; out_buf_3[2] <= out_wire_3[2];
                out_buf_1[3] <= out_wire_1[3]; out_buf_2[3] <= out_wire_2[3]; out_buf_3[3] <= out_wire_3[3];
                out_buf_1[4] <= out_wire_1[4]; out_buf_2[4] <= out_wire_2[4]; out_buf_3[4] <= out_wire_3[4];
                out_buf_1[5] <= out_wire_1[5]; out_buf_2[5] <= out_wire_2[5]; out_buf_3[5] <= out_wire_3[5];
                
                out_buf_1[6] <= out_wire_1[6]; out_buf_2[6] <= out_wire_2[6]; out_buf_3[6] <= out_wire_3[6];
                out_buf_1[7] <= out_wire_1[7]; out_buf_2[7] <= out_wire_2[7]; out_buf_3[7] <= out_wire_3[7];
                out_buf_1[8] <= out_wire_1[8]; out_buf_2[8] <= out_wire_2[8]; out_buf_3[8] <= out_wire_3[8];
                out_buf_1[9] <= out_wire_1[9]; out_buf_2[9] <= out_wire_2[9]; out_buf_3[9] <= out_wire_3[9];
                out_buf_1[10] <= out_wire_1[10]; out_buf_2[10] <= out_wire_2[10]; out_buf_3[10] <= out_wire_3[10];
                out_buf_1[11] <= out_wire_1[11]; out_buf_2[11] <= out_wire_2[11]; out_buf_3[11] <= out_wire_3[11];
                
                out_buf_1[12] <= out_wire_1[12]; out_buf_2[12] <= out_wire_2[12]; out_buf_3[12] <= out_wire_3[12];
                out_buf_1[13] <= out_wire_1[13]; out_buf_2[13] <= out_wire_2[13]; out_buf_3[13] <= out_wire_3[13];
                out_buf_1[14] <= out_wire_1[14]; out_buf_2[14] <= out_wire_2[14]; out_buf_3[14] <= out_wire_3[14];
                out_buf_1[15] <= out_wire_1[15]; out_buf_2[15] <= out_wire_2[15]; out_buf_3[15] <= out_wire_3[15];
                out_buf_1[16] <= out_wire_1[16]; out_buf_2[16] <= out_wire_2[16]; out_buf_3[16] <= out_wire_3[16];
                out_buf_1[17] <= out_wire_1[17]; out_buf_2[17] <= out_wire_2[17]; out_buf_3[17] <= out_wire_3[17];
                
                out_buf_1[18] <= out_wire_1[18]; out_buf_2[18] <= out_wire_2[18]; out_buf_3[18] <= out_wire_3[18];
                out_buf_1[19] <= out_wire_1[19]; out_buf_2[19] <= out_wire_2[19]; out_buf_3[19] <= out_wire_3[19];
                out_buf_1[20] <= out_wire_1[20]; out_buf_2[20] <= out_wire_2[20]; out_buf_3[20] <= out_wire_3[20];
                out_buf_1[21] <= out_wire_1[21]; out_buf_2[21] <= out_wire_2[21]; out_buf_3[21] <= out_wire_3[21];
                out_buf_1[22] <= out_wire_1[22]; out_buf_2[22] <= out_wire_2[22]; out_buf_3[22] <= out_wire_3[22];
                out_buf_1[23] <= out_wire_1[23]; out_buf_2[23] <= out_wire_2[23]; out_buf_3[23] <= out_wire_3[23];
            end
           
        endcase
        
    end
end

sys33 sys_arr_1 (clk, sys_rst, en, din_buf[0], din_buf[1], din_buf[2], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[0], out_wire_3[0], out_wire_2[0], out_wire_2[1], out_wire_1[1], out_wire_3[1], out_wire_3[2], out_wire_2[2], out_wire_1[2]);
sys33 sys_arr_2 (clk, sys_rst, en, din_buf[3], din_buf[4], din_buf[5], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[3], out_wire_3[3], out_wire_2[3], out_wire_2[4], out_wire_1[4], out_wire_3[4], out_wire_3[5], out_wire_2[5], out_wire_1[5]);
sys33 sys_arr_3 (clk, sys_rst, en, din_buf[6], din_buf[7], din_buf[8], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[6], out_wire_3[6], out_wire_2[6], out_wire_2[7], out_wire_1[7], out_wire_3[7], out_wire_3[8], out_wire_2[8], out_wire_1[8]);
sys33 sys_arr_4 (clk, sys_rst, en, din_buf[9], din_buf[10], din_buf[11], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[9], out_wire_3[9], out_wire_2[9], out_wire_2[10], out_wire_1[10], out_wire_3[10], out_wire_3[11], out_wire_2[11], out_wire_1[11]);
sys33 sys_arr_5 (clk, sys_rst, en, din_buf[12], din_buf[13], din_buf[14], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[12], out_wire_3[12], out_wire_2[12], out_wire_2[13], out_wire_1[13], out_wire_3[13], out_wire_3[14], out_wire_2[14], out_wire_1[14]);
sys33 sys_arr_6 (clk, sys_rst, en, din_buf[15], din_buf[16], din_buf[17], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[15], out_wire_3[15], out_wire_2[15], out_wire_2[16], out_wire_1[16], out_wire_3[16], out_wire_3[17], out_wire_2[17], out_wire_1[17]);
sys33 sys_arr_7 (clk, sys_rst, en, din_buf[18], din_buf[19], din_buf[20], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[18], out_wire_3[18], out_wire_2[18], out_wire_2[19], out_wire_1[19], out_wire_3[19], out_wire_3[20], out_wire_2[20], out_wire_1[20]);
sys33 sys_arr_8 (clk, sys_rst, en, din_buf[21], din_buf[22], din_buf[23], win_buf[1], win_buf[2], win_buf[3], 
out_wire_1[21], out_wire_3[21], out_wire_2[21], out_wire_2[22], out_wire_1[22], out_wire_3[22], out_wire_3[23], out_wire_2[23], out_wire_1[23]);


endmodule