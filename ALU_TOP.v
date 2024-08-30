module ALU_TOP #(parameter IN_DATA_WIDTH=16, ARITH_OUT_WIDTH=32, LOGIC_OUT_WIDTH=16, SHIFT_OUT_WIDTH=16, CMP_OUT_WIDTH=2)(

input  wire signed  [IN_DATA_WIDTH-1:0]  	A,B,
input  wire 								CLK, RST,
input  wire  		[3:0]					ALU_FUN,
output wire  		[SHIFT_OUT_WIDTH-1:0]	SHIFT_OUT,
output wire  		[ARITH_OUT_WIDTH-1:0]	Arith_OUT,
output wire  		[LOGIC_OUT_WIDTH-1:0]	Logic_OUT,
output wire  		[CMP_OUT_WIDTH-1:0]		CMP_OUT,
output wire									SHIFT_Flag,CMP_Flag,Arith_Flag,Logic_Flag);

wire  Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable;

Decoder_UNIT U_Decoder_UNIT (
.ALU_FUN(ALU_FUN[3:2]),
.Arith_Enable(Arith_Enable),
.Logic_Enable(Logic_Enable),
.CMP_Enable(CMP_Enable),
.Shift_Enable(Shift_Enable)
);

ARITHMETIC_UNIT #(.IN_DATA_WIDTH(IN_DATA_WIDTH),.ARITH_OUT_WIDTH(ARITH_OUT_WIDTH)) U_ARITHMETIC_UNIT (
.CLK(CLK),
.rst(RST),
.A(A),
.B(B),
.ARITH_Enable(Arith_Enable),
.ALU_FUN(ALU_FUN[1:0]),
.ARITH_OUT(Arith_OUT),
.Arith_Flag(Arith_Flag)
);

LOGIC_UNIT #(.IN_DATA_WIDTH(IN_DATA_WIDTH),.LOGIC_OUT_WIDTH(LOGIC_OUT_WIDTH)) U_LOGIC_UNIT (
.CLK(CLK),
.rst(RST),
.A(A),
.B(B),
.Logic_Enable(Logic_Enable),
.ALU_FUN(ALU_FUN[1:0]),
.LOGIC_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
);

CMP_UNIT #(.IN_DATA_WIDTH(IN_DATA_WIDTH),.CMP_OUT_WIDTH(CMP_OUT_WIDTH)) U_CMP_UNIT (
.CLK(CLK),
.rst(RST),
.A(A),
.B(B),
.CMP_Enable(CMP_Enable),
.ALU_FUN(ALU_FUN[1:0]),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)
);

SHIFT_UNIT #(.IN_DATA_WIDTH(IN_DATA_WIDTH),.SHIFT_OUT_WIDTH(SHIFT_OUT_WIDTH)) U_SHIFT_UNIT (
.CLK(CLK),
.rst(RST),
.A(A),
.B(B),
.Shift_Enable(Shift_Enable),
.ALU_FUN(ALU_FUN[1:0]),
.SHIFT_OUT(SHIFT_OUT),
.SHIFT_Flag(SHIFT_Flag)
);

endmodule