module conv2_calc_5ks_2(
	clk, rst, valid_in,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, 
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, 

	conv_out,
	valid_out
);

input clk, rst, valid_in;
input signed [11:0] out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
					out_data1_5, out_data1_6, out_data1_7, 
			
					out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
					out_data2_5, out_data2_6, out_data2_7, 
					
					out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
					out_data3_5, out_data3_6, out_data3_7;

// calc_out / 256 = conv_out
output signed [11:0] conv_out; //12bit

wire signed [19:0] calc_out;

reg signed [19:0] conv_out_1;
reg signed [19:0] conv_out_2;
reg signed [19:0] conv_out_3;

output reg valid_out;

wire signed [19:0] out_wire_1[0:7];
wire signed [19:0] out_wire_2[0:7];
wire signed [19:0] out_wire_3[0:7];
wire signed [11:0] float_side[0:23];
wire signed [7:0] float_ceiling[0:23];

reg signed [19:0] out_buf_1[0:7];
reg signed [19:0] out_buf_2[0:7];
reg signed [19:0] out_buf_3[0:7];

reg signed [7:0] weight_1 [0:24];
reg signed [7:0] weight_2 [0:24];
reg signed [7:0] weight_3 [0:24];

reg signed [7:0] win_buf[1:3];
reg signed [11:0] din_buf[0:23];

reg [4:0] count;
reg en;
reg sys_rst;
reg [4:0]line_count;
reg done;
initial begin

$readmemh("conv2_weight_21.mif", weight_1);
$readmemh("conv2_weight_22.mif", weight_2);
$readmemh("conv2_weight_23.mif", weight_3);
end

always @ (posedge clk) begin
        if(valid_in) begin
        din_buf[0] <= out_data1_0;
        din_buf[1] <= out_data1_1;
        din_buf[2] <= out_data1_2;
        din_buf[3] <= out_data1_3;
        din_buf[4] <= out_data1_4;
        din_buf[5] <= out_data1_5;
        din_buf[6] <= out_data1_6;
        din_buf[7] <= out_data1_7;
        din_buf[8] <= out_data2_0;
        din_buf[9] <= out_data2_1;
        din_buf[10] <= out_data2_2;
        din_buf[11] <= out_data2_3;
        din_buf[12] <= out_data2_4;
        din_buf[13] <= out_data2_5;
        din_buf[14] <= out_data2_6;
        din_buf[15] <= out_data2_7;
        din_buf[16] <= out_data3_0;
        din_buf[17] <= out_data3_1;
        din_buf[18] <= out_data3_2;
        din_buf[19] <= out_data3_3;
        din_buf[20] <= out_data3_4;
        din_buf[21] <= out_data3_5;
        din_buf[22] <= out_data3_6;
        din_buf[23] <= out_data3_7;
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
        done <= 0;
    end
    else begin

        
        case(count)
            5'd0: begin
                if(!valid_in && line_count == 8) begin
                    en <= 0;
                    valid_out <= 1;
                    count <= count + 1;
                end
                else if(!valid_in) begin
                    en <= 0;
                    valid_out <= 0;
                end
                else begin
                    en <= 1;
                    sys_rst <= 0;
                    win_buf[1] <= weight_1[0];
                    win_buf[2] <= weight_2[0];
                    win_buf[3] <= weight_3[0];
                    count <= count  + 1;
                end
                if(line_count > 0) begin
                    if(valid_in) valid_out <= 1;
                    conv_out_1 <= out_buf_1[0];
                    conv_out_2 <= out_buf_2[0];
                    conv_out_3 <= out_buf_3[0];
                end
            end
            5'd1: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[1];
                win_buf[2] <= weight_2[1];
                win_buf[3] <= weight_3[1];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[1];
                    conv_out_2 <= out_buf_2[1];
                    conv_out_3 <= out_buf_3[1];
                end
            end
            5'd2: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[2];
                win_buf[2] <= weight_2[2];
                win_buf[3] <= weight_3[2];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[2];
                    conv_out_2 <= out_buf_2[2];
                    conv_out_3 <= out_buf_3[2];
                end
            end
            5'd3: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[3];
                win_buf[2] <= weight_2[3];
                win_buf[3] <= weight_3[3];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[3];
                    conv_out_2 <= out_buf_2[3];
                    conv_out_3 <= out_buf_3[3];
                end
            end
            5'd4: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[4];
                win_buf[2] <= weight_2[4];
                win_buf[3] <= weight_3[4];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[4];
                    conv_out_2 <= out_buf_2[4];
                    conv_out_3 <= out_buf_3[4];
                end
            end
            5'd5: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[5];
                win_buf[2] <= weight_2[5];
                win_buf[3] <= weight_3[5];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[5];
                    conv_out_2 <= out_buf_2[5];
                    conv_out_3 <= out_buf_3[5];
                end
            end
             5'd6: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[6];
                win_buf[2] <= weight_2[6];
                win_buf[3] <= weight_3[6];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[6];
                    conv_out_2 <= out_buf_2[6];
                    conv_out_3 <= out_buf_3[6];
                end
            end
            5'd7: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[7];
                win_buf[2] <= weight_2[7];
                win_buf[3] <= weight_3[7];
                count <= count  + 1;
                
                if(line_count > 0) begin
                    conv_out_1 <= out_buf_1[7];
                    conv_out_2 <= out_buf_2[7];
                    conv_out_3 <= out_buf_3[7];
                end
            end
            5'd8: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[8];
                win_buf[2] <= weight_2[8];
                win_buf[3] <= weight_3[8];
                count <= count  + 1;
                
                valid_out <= 0;
            end
            5'd9: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[9];
                win_buf[2] <= weight_2[9];
                win_buf[3] <= weight_3[9];
                count <= count  + 1;
            end
            5'd10: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[10];
                win_buf[2] <= weight_2[10];
                win_buf[3] <= weight_3[10];
                count <= count  + 1;
            end
            5'd11: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[11];
                win_buf[2] <= weight_2[11];
                win_buf[3] <= weight_3[11];
                count <= count  + 1;
            end
            5'd12: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[12];
                win_buf[2] <= weight_2[12];
                win_buf[3] <= weight_3[12];
                count <= count  + 1;
            end
            5'd13: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[13];
                win_buf[2] <= weight_2[13];
                win_buf[3] <= weight_3[13];
                count <= count  + 1;
            end
            5'd14: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[14];
                win_buf[2] <= weight_2[14];
                win_buf[3] <= weight_3[14];
                count <= count  + 1;
            end
            5'd15: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[15];
                win_buf[2] <= weight_2[15];
                win_buf[3] <= weight_3[15];
                count <= count  + 1;
            end
             5'd16: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[16];
                win_buf[2] <= weight_2[16];
                win_buf[3] <= weight_3[16];
                count <= count  + 1;
            end
            5'd17: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[17];
                win_buf[2] <= weight_2[17];
                win_buf[3] <= weight_3[17];
                count <= count  + 1;
            end
            5'd18: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[18];
                win_buf[2] <= weight_2[18];
                win_buf[3] <= weight_3[18];
                count <= count  + 1;
            end
            5'd19: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[19];
                win_buf[2] <= weight_2[19];
                win_buf[3] <= weight_3[19];
                count <= count  + 1;
            end
            5'd20: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[20];
                win_buf[2] <= weight_2[20];
                win_buf[3] <= weight_3[20];
                count <= count  + 1;
            end
            5'd21: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[21];
                win_buf[2] <= weight_2[21];
                win_buf[3] <= weight_3[21];
                count <= count  + 1;
            end
            5'd22: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[22];
                win_buf[2] <= weight_2[22];
                win_buf[3] <= weight_3[22];
                count <= count  + 1;
            end
            5'd23: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[23];
                win_buf[2] <= weight_2[23];
                win_buf[3] <= weight_3[23];
                count <= count  + 1;
                valid_out <= 0;
            end
            5'd24: begin
                sys_rst <= 0;
                win_buf[1] <= weight_1[24];
                win_buf[2] <= weight_2[24];
                win_buf[3] <= weight_3[24];
                count <= count  + 1;
                valid_out <= 0;
            end
            5'd25: begin
                sys_rst <= 0;
                win_buf[1] <= 0;
                win_buf[2] <= 0;
                win_buf[3] <= 0;
                count <= count  + 1;
                
            end
            5'd26: begin
                sys_rst <= 1;
                //win_buf[1] <= weight_1[0];
                //win_buf[2] <= weight_2[0];
                //win_buf[3] <= weight_3[0];
                count <= 0;
                if (line_count == 24) done <= 1;
                else line_count <= line_count + 1;
                
                out_buf_1[0] <= out_wire_1[0]; out_buf_2[0] <= out_wire_2[0]; out_buf_3[0] <= out_wire_3[0];
                out_buf_1[1] <= out_wire_1[1]; out_buf_2[1] <= out_wire_2[1]; out_buf_3[1] <= out_wire_3[1];
                out_buf_1[2] <= out_wire_1[2]; out_buf_2[2] <= out_wire_2[2]; out_buf_3[2] <= out_wire_3[2];
                out_buf_1[3] <= out_wire_1[3]; out_buf_2[3] <= out_wire_2[3]; out_buf_3[3] <= out_wire_3[3];
                
                out_buf_1[4] <= out_wire_1[4]; out_buf_2[4] <= out_wire_2[4]; out_buf_3[4] <= out_wire_3[4];
                out_buf_1[5] <= out_wire_1[5]; out_buf_2[5] <= out_wire_2[5]; out_buf_3[5] <= out_wire_3[5];
                out_buf_1[6] <= out_wire_1[6]; out_buf_2[6] <= out_wire_2[6]; out_buf_3[6] <= out_wire_3[6];
                out_buf_1[7] <= out_wire_1[7]; out_buf_2[7] <= out_wire_2[7]; out_buf_3[7] <= out_wire_3[7];
                
                
            end
            
        endcase
        
    end
end

assign calc_out = conv_out_1 + conv_out_2 + conv_out_3;
assign conv_out = calc_out[19:8];

pe pe_1_1(clk, sys_rst, en, din_buf[0], win_buf[1], float_side[0], float_ceiling[0], out_wire_1[0]);
pe pe_1_2(clk, sys_rst, en, din_buf[1], win_buf[1], float_side[1], float_ceiling[1], out_wire_1[1]);
pe pe_1_3(clk, sys_rst, en, din_buf[2], win_buf[1], float_side[2], float_ceiling[2], out_wire_1[2]);
pe pe_1_4(clk, sys_rst, en, din_buf[3], win_buf[1], float_side[3], float_ceiling[3], out_wire_1[3]);
pe pe_1_5(clk, sys_rst, en, din_buf[4], win_buf[1], float_side[4], float_ceiling[4], out_wire_1[4]);
pe pe_1_6(clk, sys_rst, en, din_buf[5], win_buf[1], float_side[5], float_ceiling[5], out_wire_1[5]);
pe pe_1_7(clk, sys_rst, en, din_buf[6], win_buf[1], float_side[6], float_ceiling[6], out_wire_1[6]);
pe pe_1_8(clk, sys_rst, en, din_buf[7], win_buf[1], float_side[7], float_ceiling[7], out_wire_1[7]);

pe pe_2_1(clk, sys_rst, en, din_buf[8], win_buf[2], float_side[8], float_ceiling[8], out_wire_2[0]);
pe pe_2_2(clk, sys_rst, en, din_buf[9], win_buf[2], float_side[9], float_ceiling[9], out_wire_2[1]);
pe pe_2_3(clk, sys_rst, en, din_buf[10], win_buf[2], float_side[10], float_ceiling[10], out_wire_2[2]);
pe pe_2_4(clk, sys_rst, en, din_buf[11], win_buf[2], float_side[11], float_ceiling[11], out_wire_2[3]);
pe pe_2_5(clk, sys_rst, en, din_buf[12], win_buf[2], float_side[12], float_ceiling[12], out_wire_2[4]);
pe pe_2_6(clk, sys_rst, en, din_buf[13], win_buf[2], float_side[13], float_ceiling[13], out_wire_2[5]);
pe pe_2_7(clk, sys_rst, en, din_buf[14], win_buf[2], float_side[14], float_ceiling[14], out_wire_2[6]);
pe pe_2_8(clk, sys_rst, en, din_buf[15], win_buf[2], float_side[15], float_ceiling[15], out_wire_2[7]);

pe pe_3_1(clk, sys_rst, en, din_buf[16], win_buf[3], float_side[16], float_ceiling[16], out_wire_3[0]);
pe pe_3_2(clk, sys_rst, en, din_buf[17], win_buf[3], float_side[17], float_ceiling[17], out_wire_3[1]);
pe pe_3_3(clk, sys_rst, en, din_buf[18], win_buf[3], float_side[18], float_ceiling[18], out_wire_3[2]);
pe pe_3_4(clk, sys_rst, en, din_buf[19], win_buf[3], float_side[19], float_ceiling[19], out_wire_3[3]);
pe pe_3_5(clk, sys_rst, en, din_buf[20], win_buf[3], float_side[20], float_ceiling[20], out_wire_3[4]);
pe pe_3_6(clk, sys_rst, en, din_buf[21], win_buf[3], float_side[21], float_ceiling[21], out_wire_3[5]);
pe pe_3_7(clk, sys_rst, en, din_buf[22], win_buf[3], float_side[22], float_ceiling[22], out_wire_3[6]);
pe pe_3_8(clk, sys_rst, en, din_buf[23], win_buf[3], float_side[23], float_ceiling[23], out_wire_3[7]);



endmodule