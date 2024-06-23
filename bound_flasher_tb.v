module bound_flaser_tb;
	wire [15:0] lamp;
	reg flick;
	reg clk;
	reg rst;

	bound_flasher bf(lamp,flick,clk,rst);
	always #10 clk=~clk; 
	initial begin
	clk=0;

//	Testcase 1
//	flick=1;
//	rst=0;
//	#500;

//	Testcase 2
//	flick=1;
//	rst=1;
//	#700
//	rst=0;
	
//	Testcase 3
//	flick=1;
//	rst=0;
//	#300;
//	rst=1;
//	#700;
//	rst=0;

//	Testcase 4
//	flick=1;
//	rst=1;
//	#500;
//	rst=0;
//	#1300;
//	rst=1;
//	#900;
//	rst=0;

//	Testcase 5
//	flick=1;
//	rst=1;
//	#500
//	rst=0;
//	#250
//	rst=1;
//	#700
//	rst=0;

//	Testcase 6
	flick=1;
	rst=1;
	#500
	rst=0;
	#250
	rst=1;
	#900
	rst=0;
	flick=0;

	
	end
endmodule