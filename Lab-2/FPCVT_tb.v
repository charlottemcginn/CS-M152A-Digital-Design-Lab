module FPCVT_tb;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		//Input
		.D(D),
		//Output
		.S(S), .E(E), .F(F)
	);

	initial begin
		
		#10;
		D = 12'b111111111111;   //-1
		#100;
		$display("Floating point representation 1 S: %01b, E: %03b, F: %04b", S, E, F);
		
		#10;
		D = 12'b000000000000; //zero
		#100;
		$display("Floating point representation 2 S: %01b, E: %03b, F: %04b", S, E, F);
		
		#10;
		D = 12'b011111111111; ///most positive
		#100;
		$display("Floating point representation 3 S: %01b, E: %03b, F: %04b", S, E, F);
		
		#10;
		D = 12'b100000000000;  ///most negative
		#100;
		$display("Floating point representation 4 S: %01b, E: %03b, F: %04b", S, E, F);
		
		#10
		D=12'b011100001000;   //round down example 1800
		#100
		$display("Floating point representation 5 S: %01b, E: %03b, F: %04b", S, E, F);
		
		#10
		D=12'b101000100100;   //round up example -1500
		#100
		$display("Floating point representation 6 S: %01b, E: %03b, F: %04b", S, E, F);
	
        

	end
      
endmodule
