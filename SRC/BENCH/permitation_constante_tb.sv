`timescale 1ns/1ps

module permitation_constante_tb import ascon_pack::*;
   (
    );
   type_state constante_add_s;
   logic[3:0] round_s;
   type_state constante_add_o_s;

   permitation_constante DUT (
			      .constante_add_i(constante_add_s),
			      .round_i(round_s),
			      .constante_add_o(constante_add_o_s)
			      );


   initial
     begin
	constante_add_s[0] = 64'h0;
        constante_add_s[1] = 64'h0;
        constante_add_s[2] = 64'h0;
	constante_add_s[3] = 64'h0;
	constante_add_s[4] = 64'h0;
	round_s = 4;
	#25;
	constante_add_s[0] = 64'h80400c0600000000;
        constante_add_s[1] = 64'h0001020304050607;
        constante_add_s[2] = 64'h08090a0b0c0d0e0f;
        constante_add_s[3] = 64'h0011223344556677;
        constante_add_s[4] = 64'h8899aabbccddeeff;
	round_s = 0;
        #25;
     end
endmodule : permitation_constante_tb  
