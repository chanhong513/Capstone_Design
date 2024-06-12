module conv_5ks_2(
	clk, rst, valid_in,
	max_value_1, max_value_2, max_value_3,
	
	conv2_out_1, conv2_out_2, conv2_out_3,
	valid_out
);

input clk, rst, valid_in;
input [11:0] max_value_1, max_value_2, max_value_3;

output signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
output valid_out;

wire [11:0] out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
			out_data1_5, out_data1_6, out_data1_7, 
			
			out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
			out_data2_5, out_data2_6, out_data2_7, 
			
			out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
			out_data3_5, out_data3_6, out_data3_7;

wire valid_out_and, valid_out_1, valid_out_2, valid_out_3,
	 valid_out_conv_1, valid_out_conv_2, valid_out_conv_3;

assign valid_out_and = valid_out_1 & valid_out_2 & valid_out_3;
assign valid_out = valid_out_conv_1 & valid_out_conv_2 & valid_out_conv_3;


conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12)) 
conv2_buf_5ks_1(
	clk, rst, valid_in,
	max_value_1,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, 
	
	valid_out_1
);

conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12)) 
conv2_buf_5ks_2(
	clk, rst, valid_in,
	max_value_2,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, 
	
	valid_out_2
);

conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12))  
conv2_buf_5ks_3(
	clk, rst, valid_in,
	max_value_3,
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, 
	
	valid_out_3
);

conv2_calc_5ks_1 conv2_calc_5ks_1(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, 
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, 

	conv2_out_1,
	valid_out_conv_1
);

conv2_calc_5ks_2 conv2_calc_5ks_2(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7,  
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, 
	
	conv2_out_2,
	valid_out_conv_2
);

conv2_calc_5ks_3 conv2_calc_5ks_3(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, 
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, 
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, 
	
	conv2_out_3,
	valid_out_conv_3
);



endmodule
