module LOGIC_UNIT #(parameter IN_DATA_WIDTH=16, LOGIC_OUT_WIDTH=16)(

	input  wire 	   [IN_DATA_WIDTH-1:0]  	A,B,
	input  wire		 							CLK, Logic_Enable, rst,
	input  wire 	   [1:0] 					ALU_FUN,
	output reg         [LOGIC_OUT_WIDTH-1:0]	LOGIC_OUT,
	output reg 									Logic_Flag);

	reg [LOGIC_OUT_WIDTH-1:0] out;

	always @(posedge CLK or negedge rst) begin
		if (!rst) begin
			LOGIC_OUT <= 0;		
		end
		else begin
			LOGIC_OUT <= out;
		end
	end

	always @(posedge CLK) begin
		if ((!rst) | (!Logic_Enable)) begin
			Logic_Flag <= 0;
		end
		else begin
		if (Logic_Enable) begin
			Logic_Flag <= 1;
		end
		end
	end

	always @(*) begin
		if (Logic_Enable) begin
			case(ALU_FUN)
			2'b00: begin
					out = A & B;
				   end
			2'b01: begin
					out = A | B;
				   end
			2'b10: begin
					out = ~(A & B);
				   end
			2'b11: begin
					out = ~(A | B);
				   end
			endcase
		end
		else begin
			out = 0;
		end
	end

endmodule