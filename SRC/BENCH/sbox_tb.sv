`timescale 1ns/1ps

module sbox_tb(
	       );
   logic[4:0]sbox_s;
   logic [4:0] sbox_o_s;

   sbox DUT (
	     .sbox_i(sbox_s),
	     .sbox_o(sbox_o_s)
	     );

   initial
     begin
	sbox_s = 5'h00;
        #25;
        sbox_s = 5'h1B;
        #15;
        sbox_s = 5'h0C;
        #15;
     end
endmodule : sbox_tb	
