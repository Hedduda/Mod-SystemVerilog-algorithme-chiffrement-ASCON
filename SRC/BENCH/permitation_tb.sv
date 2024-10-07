`timescale 1ns/1ps

module permitation_tb import ascon_pack::*;
   (
    );
   logic clock_s, resetb_s, select_s;
   type_state permutation_s;
   logic [3:0] roundp_s;
   type_state permutation_o_s;

   permitation DUT (
		    .clock_i(clock_s),
		    .resetb_i(resetb_s),
		    .select_i(select_s),
		    .permutation_i(permutation_s),
		    .roundp_i(roundp_s),
		    .permutation_o(permutation_o_s)
		    );

   initial
     begin
	clock_s = 0;
	forever #5 clock_s = ~clock_s;
     end

   initial
     begin
	select_s = 1;
	permutation_s[0] = 64'h80400c0600000000;
	permutation_s[1] = 64'h0001020304050607;
	permutation_s[2] = 64'h08090a0b0c0d0e0f;
	permutation_s[3] = 64'h0011223344556677;
	permutation_s[4] = 64'h8899aabbccddeeff;
	roundp_s = 0;
	resetb_s = 0;
	#5;
	select_s = 1;
	permutation_s[0] = 64'h80400c0600000000;
	permutation_s[1] = 64'h0001020304050607;
	permutation_s[2] = 64'h08090a0b0c0d0e0f;
	permutation_s[3] = 64'h0011223344556677;
	permutation_s[4] = 64'h8899aabbccddeeff;
	roundp_s = 0;
	resetb_s = 1;
	#5;
	select_s = 0;
	roundp_s = 1;
	resetb_s = 1;
	#10;
        select_s = 0;
	roundp_s = 2;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 3;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 4;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 5;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 6;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 7;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 8;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 9;
	resetb_s = 1;
	#10;
        select_s = 0;
	roundp_s = 10;
	resetb_s = 1;
	#10;
	select_s = 0;
	roundp_s = 11;
	resetb_s = 1;
	#10;
     end // initial begin
endmodule : permitation_tb
	
	
	
	
