`timescale 1ns / 1ps

module FPCVT( D, S, E, F );

// Input 12 bit Two's Complement Number
input [11:0] D;
 
// Output 8 bit Floating Point Number
output S; 
output [2:0] E;
output [3:0] F;

// Registers for storing temporary values
reg [11:0] D_positive;
reg [2:0] e;
reg [3:0] f;
reg [3:0] sig;
reg fifth;

/// Assign sign to first index of 
assign S = D[11]; 
assign E[2:0] = e[2:0];
assign F[3:0] = f[3:0];

// Always block
always @(*)
  begin   
    // Complement if negative number
    if (D[11] == 1)
    	D_positive = (D^12'b111111111111) + 1;
    else
    	D_positive = D; 
         
    // determine the exponent, significand, and rounding
    // dependant on the number of leading 0's
    if (D_positive[10] == 1)
	begin
		e = 7;
		sig = D_positive[10:7];
		fifth = D_positive[6];
	end

    else if(D_positive[9] == 1)
	begin
		e = 6;
		sig = D_positive[9:6];
		fifth = D_positive[5];
	end
    
    else if (D_positive[8] == 1)
	begin
		e = 5;
	    	sig = D_positive[8:5];
		fifth = D_positive[4];
	end
	  
    else if (D_positive[7] == 1)
	begin
		e = 4;
		sig = D_positive[7:4];
		fifth = D_positive[3];
	end
	  
    else if (D_positive[6] == 1)
	begin
		e = 3;
		sig = D_positive[6:3];
		fifth = D_positive[2];
	end
	  
    else if (D_positive[5] == 1)
	begin
		e = 2;
		sig = D_positive[5:2];
		fifth = D_positive[1];
	end
	  
    else if (D_positive[4] == 1)
	begin
		e = 1;
		sig = D_positive[4:1];
		fifth = D_positive[0];
	end
	  
    else
	begin
		e = 0;
		sig = D_positive[3:0];
		fifth = 0;
	end
   
////rounding


// edge case: Two's Complement representation is greater than or equal to 
// the largest number that can be represented by our floating point representation
if(D_positive >= 1920)
	begin 
		e = 7;
		f = 4'b1111;
	end
// round up if our fifth digit after the last leading zero is a 1
else
	begin
		if(fifth == 1)
			begin
			  // increase our exponent if our significand overflows
				if(sig == 15)
					begin
						f = 8;
						e = e + 1;	
					end
				else
					begin
						f = sig + 1;
						e = e;
					end
		
			end
		else
			begin
				e = e;
				f = sig;
			end
	end


end

endmodule

