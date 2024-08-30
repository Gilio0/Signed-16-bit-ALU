module SHIFT_UNIT #(parameter IN_DATA_WIDTH=16, SHIFT_OUT_WIDTH=16)(

	input  wire  		[IN_DATA_WIDTH-1:0]  	A,B,
	input  wire 								CLK, Shift_Enable, rst,
	input  wire 	    [1:0] 					ALU_FUN,
	output reg  		[SHIFT_OUT_WIDTH-1:0]	SHIFT_OUT,
	output reg		 							SHIFT_Flag);

	reg [SHIFT_OUT_WIDTH-1:0] out;

	always @(posedge CLK or negedge rst) begin
		if (!rst) begin
			SHIFT_OUT <= 0;		
		end
		else begin
			SHIFT_OUT <= out;
		end
	end

	always @(posedge CLK) begin
		if ((!rst) | (!Shift_Enable)) begin
			SHIFT_Flag <= 0;
		end
		else begin
		if (Shift_Enable) begin
			SHIFT_Flag <= 1;
		end
		end
	end

	always @(*) begin
		if (Shift_Enable) begin
			case(ALU_FUN)
			2'b00: begin
					out = A >> 1;
				   end
			2'b01: begin
					out = A << 1;
				   end
			2'b10: begin
					out = B >> 1;
				   end
			2'b11: begin
					out = B << 1;
				   end
			endcase
		end
		else begin
			out = 0;
		end
	end

endmodule