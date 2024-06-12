module conv2_buf_5ks #(parameter WIDTH = 12, HEIGHT = 12, DATA_BIT = 12)
(
	clk, rst, valid_in,
	in_data, 
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, 
	
	valid_out
);

localparam KERNEL_SIZE = 5;

input clk, rst;
input valid_in;
input [DATA_BIT - 1 : 0]in_data;

output reg [DATA_BIT - 1:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
							out_data_5, out_data_6, out_data_7;
				
output reg valid_out;

reg [DATA_BIT - 1:0] buffer [0 : WIDTH * (KERNEL_SIZE + 1) - 1];

reg [DATA_BIT - 1:0] buf_count; // Index of Buffer (28 * 6)
reg [4:0] w_count; // Index of width (12)
reg [3:0] h_count; // Index of height (12)
reg [4:0] out_count;
reg [2:0] buf_flag; // Flag of data processing 0 ~ 5
wire [2:0] line_flag; // Flag of line output
wire [2:0] col_flag;
reg state; // 0 : initialize, 1: Output Selection
reg done;
reg [4:0] last_count;

assign line_flag = (rst) ? 3'b0 : w_count / 5;
assign col_flag = (rst) ? 3'b0 : w_count % 5;


always @(posedge clk) begin
	if(rst) begin
		buf_count <= 0;
		w_count <= 0;
		out_count<=0;
		h_count <= 0;
		//line_flag <= 0;
		//col_flag <= 0;
		buf_flag <= 0;
		state <= 0;
		valid_out <= 0;
		done <= 0;
	end
	else begin
	   if(done) buf_count <= 0;
	    else if(valid_in) begin
	    buffer[buf_count] <= in_data;
	     buf_count <= buf_count + 1;
	     end
		if(buf_count == WIDTH * (KERNEL_SIZE + 1) - 1) begin
			if(valid_in) buf_count <= 0;
		end
		
		
		// Initialization
		if(!state) begin
			if(buf_count == WIDTH * KERNEL_SIZE - 1 && valid_in) begin
				state <= 1;
			end
		end
		
		// Output Selection
		else begin // state == 0
			if(w_count == 1) valid_out <= 1;
			if(w_count == 0 && valid_in) valid_out <= 1;
		    else if(w_count == 0) begin
		      w_count <= 0;
		    end
		    else w_count <= w_count + 1;
            if(valid_in) w_count <= w_count + 1; 
            
			if(h_count == 7) begin
			 if(last_count < 20) last_count <= last_count + 1;
			 else begin
			     w_count <= w_count + 1;
			     valid_out <= 1;
			 end
			end
			//line_flag <= (w_count) / 5;
			//col_flag <= (w_count) % 5;
			
			// Useless Value
		    
            
			if(w_count == 5'd25) begin
				buf_flag <= buf_flag + 1;
				if(buf_flag == KERNEL_SIZE) begin
					buf_flag <= 0;
				end
				valid_out<=0;
				
				w_count <= 0;
				//line_flag <= 0;
				//col_flag <= 0;
				if(h_count == HEIGHT - 5) begin
					h_count <= 0;
					state <= 0;
					done <= 1;
				end
				else if(h_count == 6) begin
				    h_count <= h_count + 1;
				    last_count <= 0;
				end
				else h_count <= h_count + 1;
				
			end
			
					
			// Buffer Output Selection
			if(buf_flag == 3'd0) begin 
				out_data_0 <= buffer[col_flag + line_flag * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + line_flag * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + line_flag * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + line_flag * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + line_flag * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + line_flag * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + line_flag * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + line_flag * WIDTH]; 
				

			end
			else if(buf_flag == 3'd1) begin 
				out_data_0 <= buffer[col_flag + (line_flag + 1) * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + (line_flag + 1) * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + (line_flag + 1) * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + (line_flag + 1) * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + (line_flag + 1) * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + (line_flag + 1) * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + (line_flag + 1) * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + (line_flag + 1) * WIDTH]; 
				
			end	
			else if(buf_flag == 3'd2) begin
				out_data_0 <= buffer[col_flag + ((line_flag + 2) % 6) * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + ((line_flag + 2) % 6) * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + ((line_flag + 2) % 6) * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + ((line_flag + 2) % 6) * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + ((line_flag + 2) % 6) * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + ((line_flag + 2) % 6) * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + ((line_flag + 2) % 6) * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + ((line_flag + 2) % 6) * WIDTH]; 
				
			end
			else if(buf_flag == 3'd3) begin
				out_data_0 <= buffer[col_flag + ((line_flag + 3) % 6) * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + ((line_flag + 3) % 6) * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + ((line_flag + 3) % 6) * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + ((line_flag + 3) % 6) * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + ((line_flag + 3) % 6) * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + ((line_flag + 3) % 6) * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + ((line_flag + 3) % 6) * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + ((line_flag + 3) % 6) * WIDTH]; 
				
			end
			else if(buf_flag == 3'd4) begin
				out_data_0 <= buffer[col_flag + ((line_flag + 4) % 6) * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + ((line_flag + 4) % 6) * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + ((line_flag + 4) % 6) * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + ((line_flag + 4) % 6) * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + ((line_flag + 4) % 6) * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + ((line_flag + 4) % 6) * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + ((line_flag + 4) % 6) * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + ((line_flag + 4) % 6) * WIDTH]; 
			
			end
			else if(buf_flag == 3'd5) begin
				out_data_0 <= buffer[col_flag + ((line_flag + 5) % 6) * WIDTH];
				out_data_1 <= buffer[col_flag + 1 + ((line_flag + 5) % 6) * WIDTH]; 
				out_data_2 <= buffer[col_flag + 2 + ((line_flag + 5) % 6) * WIDTH]; 
				out_data_3 <= buffer[col_flag + 3 + ((line_flag + 5) % 6) * WIDTH]; 
				out_data_4 <= buffer[col_flag + 4 + ((line_flag + 5) % 6) * WIDTH];
				out_data_5 <= buffer[col_flag + 5 + ((line_flag + 5) % 6) * WIDTH]; 
				out_data_6 <= buffer[col_flag + 6 + ((line_flag + 5) % 6) * WIDTH]; 
				out_data_7 <= buffer[col_flag + 7 + ((line_flag + 5) % 6) * WIDTH]; 
			
			end
			
		end
	end
end
endmodule

