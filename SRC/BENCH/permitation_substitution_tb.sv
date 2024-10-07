`timescale 1ns/1ps

module permitation_substitution_tb import ascon_pack::*;
   (
    );
   type_state substitution_s;
   type_state substitution_o_s;
   
   permitation_substitution DUT(
       .substitution_i(substitution_s),
       .substitution_o(substitution_o_s)
				);

  initial
   begin
      substitution_s[0] = 64'h00;
      substitution_s[1] = 64'h00;
      substitution_s[2] = 64'h00;
      substitution_s[3] = 64'h00;
      substitution_s[4] = 64'h00;
      #10;
      substitution_s[0] = 64'h80400c0600000000;
      substitution_s[1] = 64'h0001020304050607;
      substitution_s[2] = 64'h08090a0b0c0d0eff;
      substitution_s[3] = 64'h0011223344556677;
      substitution_s[4] = 64'h8899aabbccddeeff;
      #30;
      substitution_s[0] = 64'he05e3fcced08e4f0;
      substitution_s[1] = 64'h0dc4f1a5aea83522;
      substitution_s[2] = 64'hfd3d3d3d3d3d3d57;

      substitution_s[3] = 64'hdcd8f4c7e363e010;
      substitution_s[4] = 64'hdcdddddfd9dddddd;
      #25;
   end // initial begin
endmodule : permitation_substitution_tb
      
      
