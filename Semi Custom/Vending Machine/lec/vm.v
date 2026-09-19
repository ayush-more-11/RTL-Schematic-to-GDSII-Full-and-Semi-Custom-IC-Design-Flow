module vendingMachine (input clk, reset, two_in, one_in, 
			output choco_out, chng_out);

	wire rst = 1'b1;
	wire rstout;
	reg sel;
	reg [2:0] state, nxt_state;
	
	parameter idle = 3'b000;
	parameter two_rs = 3'b001;
	parameter one_rs = 3'b010;
	parameter chocoout = 3'b011;
	parameter chngout = 3'b100;
	
	assign rstout = sel ? rst : reset;


	always @(posedge clk or posedge rstout) begin 
		if(rstout) 
			state <= idle;
		else 
			state <= nxt_state;
	end

	always @(negedge clk) begin 
		sel <= ( state == chocoout | state == chngout );
	end	

	

	always@(*) begin
		case(state)
			idle: if(two_in & ~one_in)
				nxt_state = two_rs;
				else if (one_in & ~two_in)
					nxt_state = one_rs;
					else nxt_state = idle;


			two_rs: if(two_in & ~one_in)
					nxt_state = chngout;
				else if (one_in & ~two_in)
					nxt_state = chocoout;
				else if (~two_in & ~one_in)
					nxt_state = two_rs;
				else nxt_state = idle;

			one_rs: if(two_in & ~one_in)
					nxt_state = chocoout;
				else if (one_in & ~two_in)
					nxt_state = two_rs;
				else if (~two_in & ~one_in)
					nxt_state = one_rs;
				else nxt_state = idle; 

			chocoout: nxt_state = idle; 
			chngout: nxt_state = idle;
			default: nxt_state = idle;
		endcase
	end

assign choco_out = ( state == chocoout | state ==chngout );
assign chng_out = ( state == chngout);

endmodule






			
