module vm_tb();
	reg clk, reset, two_in, one_in;
	wire choco_out, chng_out;

	vendingMachine dut(.clk(clk), .reset(reset), .two_in(two_in), .one_in(one_in), .choco_out(choco_out), .chng_out(chng_out));

	always begin
		clk <= 1; #50;
		clk <= 0; #50;
	end

	initial begin
	
		two_in <= 0; one_in <= 0;
		reset <= 1; #120; 
		reset <=0;

		#80; 	two_in <= 1;
		#300;	two_in <= 0; one_in <= 1;
		#300;	two_in <= 1; one_in <= 0;
		#50;	two_in <= 0; one_in <= 1;
		#50;	one_in <= 0;
		#200;	one_in <= 1;
		#50;	two_in <= 1; one_in <= 0;
		#50;	two_in <= 0; 
		#200;	one_in <= 1;
		#100;	two_in <= 1; one_in <= 0;
		#200;	two_in <= 0; one_in <= 0;
	end
initial begin 
	#2000;
	$finish();
end

endmodule
