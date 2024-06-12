module mnist_cnn(
	clk, rst, in_data,
	
	decision, valid_out_o
);

input clk, rst;
input [7:0] in_data;

output [3:0] decision;
output valid_out_o;




reg state ;
wire signed [11:0] conv_out_1, conv_out_2, conv_out_3;
wire signed [13:0] avg_value_1, avg_value_2, avg_value_3;
wire signed [11:0] conv2_in_1, conv2_in_2, conv2_in_3;
wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
wire signed [13:0] avg_value2_1, avg_value2_2, avg_value2_3;
wire signed [11:0] fc_in_1, fc_in_2, fc_in_3;
wire signed [11:0] fc_out_data;
wire valid_out_1, valid_out_2, valid_out_3, valid_out_4, valid_out_5, valid_out;
wire rst_s;
reg valid;

// assign rst_s = rst && state;

always @(posedge clk) begin
    if (!valid_out && rst) begin
        valid <= 'd0;
    end
    if (valid_out) begin
        valid <= 'd1;
    end
end 


conv_5ks_1 conv_5ks_1(
	clk, rst, in_data,
	
	conv_out_1, conv_out_2, conv_out_3,
	valid_out_1
);

avg_pool #(.CONV_BIT(12), .HALF_WIDTH(12), .HALF_HEIGHT(12), .HALF_WIDTH_BIT(4)) 
avg_pool_1(
    clk, rst,
    valid_out_1,
    conv_out_1, conv_out_2, conv_out_3,
	
    avg_value_1, avg_value_2, avg_value_3,
    valid_out_2
);

// ReLU for Layer 1
assign conv2_in_1 = (avg_value_1 < 0) ? 12'b0 : avg_value_1 >> 2;
assign conv2_in_2 = (avg_value_2 < 0) ? 12'b0 : avg_value_2 >> 2;
assign conv2_in_3 = (avg_value_3 < 0) ? 12'b0 : avg_value_3 >> 2;

conv_5ks_2 conv_5ks_2(
	clk, rst, valid_out_2,
	conv2_in_1, conv2_in_2, conv2_in_3,
	
	conv2_out_1, conv2_out_2, conv2_out_3,
	valid_out_3
);

avg_pool #(.CONV_BIT(12), .HALF_WIDTH(4), .HALF_HEIGHT(4), .HALF_WIDTH_BIT(3)) 
avg_pool_2(
    clk, rst,
    valid_out_3,
    conv2_out_1, conv2_out_2, conv2_out_3,
	
    avg_value2_1, avg_value2_2, avg_value2_3,
    valid_out_4
);

//Relu for Layer 2
assign fc_in_1 = (avg_value2_1 < 0) ? 12'b0 : avg_value2_1 >> 2;
assign fc_in_2 = (avg_value2_2 < 0) ? 12'b0 : avg_value2_2 >> 2;
assign fc_in_3 = (avg_value2_3 < 0) ? 12'b0 : avg_value2_3 >> 2;

fc_layer #(.NUM_INPUT_DATA(48), .NUM_OUTPUT_DATA(10))
fc_layer(
    clk, rst, valid_out_4,
    fc_in_1,
    fc_in_2,
    fc_in_3,

    valid_out_5,
    fc_out_data
);

//Comparator instead of Activation
//No need to use softmax just for testing, without training
comparator #(.INPUT_BITS(12), .NUM_CLASS(10))
comparator(
    clk, rst,
    valid_out_5,
    fc_out_data,
			   
    decision,
	valid_out
);  

// output assignment

assign valid_out_o = valid;

endmodule
