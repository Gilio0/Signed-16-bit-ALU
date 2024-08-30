module ARITHMETIC_UNIT #(parameter IN_DATA_WIDTH=16, ARITH_OUT_WIDTH=32)(

	input  wire signed [IN_DATA_WIDTH-1:0]  	A,B,
	input  wire 								CLK, ARITH_Enable, rst,
	input  wire 	   [1:0] 					ALU_FUN,
	output reg  signed [ARITH_OUT_WIDTH-1:0]	ARITH_OUT,
	output reg		 							Arith_Flag);

	reg signed [ARITH_OUT_WIDTH-1:0] out;

	always @(posedge CLK or negedge rst) begin
		if (!rst) begin
			ARITH_OUT <= 0;
		end
		else begin
			ARITH_OUT <= out;
		end
	end

	always @(posedge CLK) begin
		if ((!rst) | (!ARITH_Enable)) begin
			Arith_Flag <= 0;
		end
		else begin
		if (ARITH_Enable) begin
			Arith_Flag <= 1;
		end
		end
	end

	always @(*) begin
		if (ARITH_Enable) begin
			case(ALU_FUN)
			2'b00: begin
					out = A + B;
				   end
			2'b01: begin
					out = A - B;
				   end
			2'b10: begin
					out = A * B;
				   end
			2'b11: begin
					out = A / B;
				   end
			endcase
		end
		else begin
			out = 0;
		end
	end

endmodule