module tb;
	wire [15:0] led;
	reg flick;
	reg clk;

	bound_flash bf(led,flick,clk);
	always #10 clk=~clk; 
	initial begin
	clk=0;

//	Situation 1
	flick=1;#2000;

	flick=0;#1000;

	flick=1;#50;

	flick=0;

//	Situation 2

//	flick=0;#100;
//
//	flick=1; #500;
//	flick=0; 


	
	end
endmodule