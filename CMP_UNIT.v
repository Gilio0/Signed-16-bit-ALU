module CMP_UNIT #(parameter IN_DATA_WIDTH=16,CMP_OUT_WIDTH=16)(

	input  wire 	   [IN_DATA_WIDTH-1:0]  A,B,
	input  wire 							CLK, CMP_Enable, rst,
	input  wire 	   [1:0] 				ALU_FUN,
	output reg 		   [CMP_OUT_WIDTH-1:0]	CMP_OUT,
	output reg		 						CMP_Flag);

	reg [CMP_OUT_WIDTH-1:0] out;

	always @(posedge CLK or negedge rst) begin
		if (!rst) begin
			CMP_OUT <= 0;		
		end
		else begin
			CMP_OUT <= out;
		end
	end

	always @(posedge CLK) begin
		if ((!rst) | (!CMP_Enable)) begin
			CMP_Flag <= 0;
		end
		else begin
		if (CMP_Enable) begin
			CMP_Flag <= 1;
		end
		end
	end


	always @(*) begin
		if (CMP_Enable) begin
			case(ALU_FUN)
			2'b00: begin
					out = 0;
				   end
			2'b01: begin
					if(A == B) begin
						out = 1;
					end
					else begin
						out = 0;
					end
				   end
			2'b10: begin
					if(A > B) begin
						out = 2;
					end
					else begin
						out = 0;
					end
				   end
			2'b11: begin
					if(A < B) begin
						out = 3;
					end
					else begin
						out = 0;
					end
				   end
			endcase
		end
		else begin
			out = 0;
		end
	end

endmodule