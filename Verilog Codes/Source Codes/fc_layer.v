module fc_layer #(parameter NUM_INPUT_DATA = 48, NUM_OUTPUT_DATA = 10)
(
    clk, rst, valid_in,
    in_data_1,
    in_data_2,
    in_data_3,

    valid_out,
    out_data
);

localparam DIVIDED_NUM_INPUT = 16; // 48/3
localparam NUM_INPUT_DATA_BITS = 5; // ceil(log_2(48/3)) + 1

input clk, rst, valid_in;
input signed [11:0] in_data_1, in_data_2, in_data_3;

output reg signed [11:0] out_data;
output reg valid_out;

reg sys_rst;
reg en;

reg state; // 0 : Buffer Stacking // 1 : Calculation

reg [NUM_INPUT_DATA_BITS - 1 : 0] buf_count; // Buffer Stacking Count

reg [3:0] out_count; // Output Change (10)

reg signed [11:0] buffer [0 : NUM_INPUT_DATA - 1];

reg signed [7: 0] weight [0 : NUM_INPUT_DATA * NUM_OUTPUT_DATA - 1];

reg [5:0] count;

reg signed [12:0] din_buf;
reg signed [7:0] win_buf [0:9];

wire signed [11:0] float_side[0:9];
wire signed [7:0] float_ceiling[0:9];
wire signed [19:0] out_wire [0:9];

reg signed [19:0] output_reg [0:9];

initial begin
    $readmemh("fc_weight.mif", weight);
end



always @ (posedge clk) begin
    if(rst) begin
        valid_out <= 0;
		buf_count <= 0;
		out_count <= 0;
        state <= 0;
        count <= 0;
        sys_rst <= 1;
    end
	else begin
		
		if(valid_in == 1) begin
			// Buffer Stacking
			if(state == 0) begin
				buffer[buf_count] <= in_data_1;
				buffer[DIVIDED_NUM_INPUT + buf_count] <= in_data_2;
				buffer[DIVIDED_NUM_INPUT * 2 + buf_count] <= in_data_3;
				
				// Count 16 (48 / 3)
				buf_count <= buf_count + 1;
				if(buf_count == DIVIDED_NUM_INPUT - 1) begin
					buf_count <= 0;
					state <= 1;
					sys_rst <= 1;
				end
			end
		end	
			// Calculation
	   if (state == 1) begin
	       case(count) 
	           6'd0: begin
	               sys_rst <= 0;
	               //out_count <= 0;
	               en <= 1;
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd1: begin
	               sys_rst <= 0;
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd2: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd3: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd4: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd5: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd6: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd7: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd8: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd9: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd10: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd11: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd12: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd13: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd14: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd15: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd16: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd17: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd18: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd19: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd20: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd21: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd22: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd23: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd24: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd25: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd26: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd27: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd28: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd29: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd30: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd31: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd32: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd33: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd34: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd35: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd36: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd37: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd38: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd39: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd40: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd41: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd42: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd43: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd44: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd45: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd46: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	           end
	           6'd47: begin
	               din_buf <= buffer[count];
	               win_buf[0] <= weight[count];
	               win_buf[1] <= weight[count + NUM_INPUT_DATA];
	               win_buf[2] <= weight[count + 2 * NUM_INPUT_DATA];
	               win_buf[3] <= weight[count + 3 * NUM_INPUT_DATA];
	               win_buf[4] <= weight[count + 4 * NUM_INPUT_DATA];
	               win_buf[5] <= weight[count + 5 * NUM_INPUT_DATA];
	               win_buf[6] <= weight[count + 6 * NUM_INPUT_DATA];
	               win_buf[7] <= weight[count + 7 * NUM_INPUT_DATA];
	               win_buf[8] <= weight[count + 8 * NUM_INPUT_DATA];
	               win_buf[9] <= weight[count + 9 * NUM_INPUT_DATA];
	               
	               count <= count + 1;
	               
	           end
	           6'd48: begin 
	               en <= 0; 
	               count <= count + 1; 
	               end
	           default: begin
			       if(out_count == 10) begin
				       valid_out <= 0;
			       end
			       else begin 
			         valid_out <= 1;
			         out_data <= out_wire[out_count][19:8];
			         out_count <= out_count + 1;
			       end
			   end
	       endcase
			
		end

	end	
end

pe pe_1(clk, sys_rst, en, din_buf, win_buf[0], float_side[0], float_ceiling[0], out_wire[0]);
pe pe_2(clk, sys_rst, en, din_buf, win_buf[1], float_side[1], float_ceiling[1], out_wire[1]);
pe pe_3(clk, sys_rst, en, din_buf, win_buf[2], float_side[2], float_ceiling[2], out_wire[2]);
pe pe_4(clk, sys_rst, en, din_buf, win_buf[3], float_side[3], float_ceiling[3], out_wire[3]);
pe pe_5(clk, sys_rst, en, din_buf, win_buf[4], float_side[4], float_ceiling[4], out_wire[4]);
pe pe_6(clk, sys_rst, en, din_buf, win_buf[5], float_side[5], float_ceiling[5], out_wire[5]);
pe pe_7(clk, sys_rst, en, din_buf, win_buf[6], float_side[6], float_ceiling[6], out_wire[6]);
pe pe_8(clk, sys_rst, en, din_buf, win_buf[7], float_side[7], float_ceiling[7], out_wire[7]);
pe pe_9(clk, sys_rst, en, din_buf, win_buf[8], float_side[8], float_ceiling[8], out_wire[8]);
pe pe_10(clk, sys_rst, en, din_buf, win_buf[9], float_side[9], float_ceiling[8], out_wire[9]);

endmodule
