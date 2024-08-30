`timescale 1us/1ns

module ALU_TB ();

localparam IN_DATA_WIDTH = 16;
localparam ARITH_OUT_WIDTH = 32;
localparam LOGIC_OUT_WIDTH = 16;
localparam SHIFT_OUT_WIDTH = 16;
localparam CMP_OUT_WIDTH = 2;

reg  signed  [IN_DATA_WIDTH-1:0]    A_TB, B_TB;
wire 	     [SHIFT_OUT_WIDTH-1:0]  SHIFT_OUT_TB;
wire signed  [ARITH_OUT_WIDTH-1:0]  Arith_OUT_TB;
wire 	     [LOGIC_OUT_WIDTH-1:0]  Logic_OUT_TB;
wire 	     [CMP_OUT_WIDTH-1:0]    CMP_OUT_TB;
reg  		 [3:0] 				    ALU_FUN_TB;
reg  		  					    CLK_TB, RST_TB;
wire 		   					    SHIFT_Flag_TB, CMP_Flag_TB, Arith_Flag_TB, Logic_Flag_TB;


ALU_TOP #(.IN_DATA_WIDTH(IN_DATA_WIDTH),
		  .ARITH_OUT_WIDTH(ARITH_OUT_WIDTH),
		  .LOGIC_OUT_WIDTH(LOGIC_OUT_WIDTH),
		  .SHIFT_OUT_WIDTH(SHIFT_OUT_WIDTH),
		  .CMP_OUT_WIDTH(CMP_OUT_WIDTH)) 
DUT_ALU_TOP (
.A(A_TB),
.B(B_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.ALU_FUN(ALU_FUN_TB),
.SHIFT_OUT(SHIFT_OUT_TB),
.Arith_OUT(Arith_OUT_TB),
.Logic_OUT(Logic_OUT_TB),
.CMP_OUT(CMP_OUT_TB),
.SHIFT_Flag(SHIFT_Flag_TB),
.CMP_Flag(CMP_Flag_TB),
.Arith_Flag(Arith_Flag_TB),
.Logic_Flag(Logic_Flag_TB)
);


always begin
	#4 CLK_TB = ~CLK_TB;
	#6 CLK_TB = ~CLK_TB;
end

initial begin
	CLK_TB = 0;
	RST_TB = 0;
	A_TB = 0;
	B_TB = 0;
	ALU_FUN_TB = 0;

	#10 
	RST_TB = 1;
	A_TB = 'shFFFC;//A_TB = -4
	B_TB = 'shFFF6;//B_TB = -10
	ALU_FUN_TB = 4'b0000 ;

	#10
	if (Arith_OUT_TB == -'d14 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh002B;//43
	
	#10
	if (Arith_OUT_TB == 'd33 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	
	B_TB = 'sh0018;//24

	#10
	if (Arith_OUT_TB == 'd67 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	
	A_TB = 'shFFE1;//-31

	#10
	if (Arith_OUT_TB == -'d7 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh8000;//max neg
	B_TB = 'sh8000;//max neg

	#10
	if (Arith_OUT_TB == -'d65536 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh7FFF;//max pos
	B_TB = 'sh7FFF;//max pos

	#10
	if (Arith_OUT_TB == 'd65534 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Addition A = %0d + B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Addition A = %0d + B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	ALU_FUN_TB = 4'b0001;
	A_TB = 'shFFE1;//-31
	B_TB = 'sh0018;//24

	#10
	if (Arith_OUT_TB == -'d55 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Subtraction A = %0d - B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Subtraction A = %0d - B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh0047;//71

	#10
	if (Arith_OUT_TB == 'd47 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Subtraction A = %0d - B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Subtraction A = %0d - B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	B_TB = 'shFFE3;//-29

	#10
	if (Arith_OUT_TB == 'd100 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Subtraction A = %0d - B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Subtraction A = %0d - B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'shFF58;

	#10
	if (Arith_OUT_TB == -'d139 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Subtraction A = %0d - B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Subtraction A = %0d - B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh8000;//max neg
	B_TB = 'sh7FFF;//max pos

	#10
	if (Arith_OUT_TB == -'d65535 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Subtraction A = %0d - B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Subtraction A = %0d - B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	ALU_FUN_TB = 4'b0010;
	A_TB = 'shFF58;
	B_TB = 'shFFE3;//-29

	#10
	if (Arith_OUT_TB == 'd4872 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Multiolication A = %0d * B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Multiolication A = %0d * B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh0047;//71

	#10
	if (Arith_OUT_TB == -'d2059 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Multiolication A = %0d * B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Multiolication A = %0d * B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	B_TB = 'sh022B;//555

	#10
	if (Arith_OUT_TB == 'd39405 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Multiolication A = %0d * B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Multiolication A = %0d * B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'shFF9E;//-98

	#10
	if (Arith_OUT_TB == -'d54390 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Multiolication A = %0d * B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Multiolication A = %0d * B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh8000;//max neg
	B_TB = 'sh7FFF;//max pos

	#10
	if (Arith_OUT_TB == -'d1073709056 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Multiolication A = %0d * B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Multiolication A = %0d * B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	ALU_FUN_TB = 4'b0011;
	A_TB = 'shFF9E;//-98
	B_TB = 'sh022B;//555

	#10
	if (Arith_OUT_TB == 'd0 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Division A = %0d / B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Division A = %0d / B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sd4000;
	B_TB = 'shFFEC;//-20

	#10
	if (Arith_OUT_TB == -'d200 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Division A = %0d / B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Division A = %0d / B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'shF060;//-4000
	B_TB = 'shFFEC;//-20

	#10
	if (Arith_OUT_TB == 'd200 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Division A = %0d / B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Division A = %0d / B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'shFFEC;//-20
	B_TB = 'sd4000;

	#10
	if (Arith_OUT_TB == 0 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Division A = %0d / B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Division A = %0d / B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'sh8000;
	B_TB = 'sh8000;

	#10
	if (Arith_OUT_TB == 1 && Arith_Flag_TB == 1 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Division A = %0d / B = %0d IS PASSED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end
	else begin
		$display ("Division A = %0d / B = %0d IS FAILED, Arith_OUT = %0d",A_TB,B_TB,Arith_OUT_TB);
	end

	A_TB = 'b1010010111110000;
	B_TB = 'b1111001110100101;
	ALU_FUN_TB = 4'b0100;

	#10
	if (Logic_OUT_TB == 'b1010000110100000 && Arith_Flag_TB == 0 && Logic_Flag_TB == 1 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("AND %0d & %0d IS PASSED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end
	else begin
		$display ("AND %0d & %0d IS FAILED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end

	ALU_FUN_TB = 4'b0101;

	#10
	if (Logic_OUT_TB == 'b1111011111110101 && Arith_Flag_TB == 0 && Logic_Flag_TB == 1 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("OR %0d & %0d IS PASSED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end
	else begin
		$display ("OR %0d & %0d IS FAILED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end

	ALU_FUN_TB = 4'b0110;

	#10
	if (Logic_OUT_TB == 'b0101111001011111 && Arith_Flag_TB == 0 && Logic_Flag_TB == 1 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("NAND %0d & %0d IS PASSED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end
	else begin
		$display ("NAND %0d & %0d IS FAILED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end

	RST_TB = 0;
	#10
	if (Logic_OUT_TB == 0 && Arith_OUT_TB == 0 && CMP_OUT_TB == 0 && SHIFT_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("Reset PASSED");
	end
	else begin
		$display ("Reset Failed");
	end

	RST_TB = 1;
	ALU_FUN_TB = 4'b0111;

	#10
	if (Logic_OUT_TB == 'b0000100000001010 && Arith_Flag_TB == 0 && Logic_Flag_TB == 1 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 0)begin
		$display ("NOR %0d & %0d IS PASSED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end
	else begin
		$display ("NOR %0d & %0d IS FAILED, Logic_OUT = %0d",A_TB,B_TB,Logic_OUT_TB);
	end

	ALU_FUN_TB = 4'b1000;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("NOP A = %0d, B = %0d IS PASSED, CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("NOP A = %0d, B = %0d IS FAILED, CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	ALU_FUN_TB = 4'b1001;
	A_TB = 999;
	B_TB = 999;

	#10
	if (CMP_OUT_TB == 1 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("Equal compare A = %0d, B = %0d IS PASSED ,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("Equal compare A = %0d, B = %0d IS FAILED ,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	
	A_TB = 445;
	B_TB = 999;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("Equal compare A = %0d, B = %0d IS PASSED ,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("Equal compare A = %0d, B = %0d IS FAILED ,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	A_TB = 50;
	B_TB = 25;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("Equal compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("Equal compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	ALU_FUN_TB = 4'b1010;
	A_TB = 90;
	B_TB = 50;

	#10
	if (CMP_OUT_TB == 2 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("gt compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("gt compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	A_TB = 300;
	B_TB = 400;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("gt compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("gt compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	A_TB = 500;
	B_TB = 500;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("gt compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("gt compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	ALU_FUN_TB = 4'b1011;	
	A_TB = 999;
	B_TB = 999;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("sm compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("sm compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	A_TB = 5;
	B_TB = 10;

	#10
	if (CMP_OUT_TB == 3 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("sm compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("sm compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	A_TB = 465;
	B_TB = 464;

	#10
	if (CMP_OUT_TB == 0 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 1 && SHIFT_Flag_TB == 0)begin
		$display ("sm compare A = %0d, B = %0d IS PASSED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end
	else begin
		$display ("sm compare A = %0d, B = %0d IS FAILED,CMP_OUT = %0d",A_TB,B_TB,CMP_OUT_TB);
	end

	ALU_FUN_TB = 4'b1100;	
	A_TB = 'b1111000010100101;

	#10
	if (SHIFT_OUT_TB == 'b0111100001010010 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 1)begin
		$display ("shift right A, A = %0d, B = %0d IS PASSED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end
	else begin
		$display ("shift right A, A = %0d, B = %0d IS FAILED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end

	ALU_FUN_TB = 4'b1101;	

	#10
	if (SHIFT_OUT_TB == 'b1110000101001010 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 1)begin
		$display ("shift left A, A = %0d, B = %0d IS PASSED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end
	else begin
		$display ("shift left A, A = %0d, B = %0d IS FAILED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end

	ALU_FUN_TB = 4'b1110;
	A_TB = 9;
	B_TB = 'b1111111111111111;

	#10
	if (SHIFT_OUT_TB == 'b0111111111111111 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 1)begin
		$display ("shift right B, A = %0d, B = %0d IS PASSED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end
	else begin
		$display ("shift right B, A = %0d, B = %0d IS FAILED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end

	ALU_FUN_TB = 4'b1111;

	#10
	if (SHIFT_OUT_TB == 'b1111111111111110 && Arith_Flag_TB == 0 && Logic_Flag_TB == 0 && CMP_Flag_TB == 0 && SHIFT_Flag_TB == 1)begin
		$display ("shift left B, A = %0d, B = %0d IS PASSED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end
	else begin
		$display ("shift left B, A = %0d, B = %0d IS FAILED,SHIFT_OUT = %0d",A_TB,B_TB,SHIFT_OUT_TB);
	end

	#40

	$finish;

end

endmodule