module sys33 (
    input clk, rst, en,
    input [11:0] side1, side2, side3,
    input [7:0] ceiling1, ceiling2, ceiling3,
    output [19:0] out_data_out_11, out_data_out_12, out_data_out_13, 
                  out_data_out_21, out_data_out_22, out_data_out_23, 
                  out_data_out_31, out_data_out_32, out_data_out_33
);

wire [11:0] shift_side_1, shift_side_2, shift_side_3;
wire [7:0] shift_ceiling_1, shift_ceiling_2, shift_ceiling_3;
wire [11:0] shift2_side_1, shift2_side_2, shift2_side_3;
wire [7:0] shift2_ceiling_1, shift2_ceiling_2, shift2_ceiling_3;
wire [11:0] shift3_side_3, shift3_side_2, shift3_side_1;
wire [7:0] shift3_ceiling_1, shift3_ceiling_2, shift3_ceiling_3;

pe PE_11(clk, rst, en, side1, ceiling1, shift_side_1, shift_ceiling_1, out_data_out_11);
pe PE_12(clk, rst, en, shift_side_1, shift_ceiling_3, shift2_side_1, shift2_ceiling_1, out_data_out_12);
pe PE_13(clk, rst, en, shift2_side_1, shift2_ceiling_3, shift3_side_1, shift3_ceiling_1,out_data_out_13);

pe PE_21(clk, rst, en, side2, ceiling2, shift_side_2,shift_ceiling_2,out_data_out_21);
pe PE_22(clk, rst, en, shift_side_2, shift_ceiling_1, shift2_side_2,shift2_ceiling_2,out_data_out_22);
pe PE_23(clk, rst, en, shift2_side_2, shift2_ceiling_1, shift3_side_2, shift3_ceiling_2,out_data_out_23);

pe PE_31(clk, rst, en, side3, ceiling3, shift_side_3,shift_ceiling_3,out_data_out_31);
pe PE_32(clk, rst, en, shift_side_3, shift_ceiling_2, shift2_side_3, shift2_ceiling_3,out_data_out_32);
pe PE_33(clk, rst, en, shift2_side_3, shift2_ceiling_2, shift3_side_3, shift3_ceiling_3,out_data_out_33);

endmodule