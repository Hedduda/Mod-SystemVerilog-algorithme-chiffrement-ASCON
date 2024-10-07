`timescale 1ns/1ps

module permitation_diffusion_tb import ascon_pack::*;
   (
    );
   type_state diffusion_s;
   type_state  diffusion_o_s;

   permitation_diffusion DUT (
			      .diffusion_i(diffusion_s),
			      .diffusion_o(diffusion_o_s)
			      );

   initial
     begin
	diffusion_s[0] = 64'h8859263f4c5d6e8f;
	diffusion_s[1] = 64'h00c18e8584858607;
	diffusion_s[2] = 64'h7f7f7f7f7f7f7f8f;
	diffusion_s[3] = 64'h80c0848680808070;
	diffusion_s[4] = 64'h8888888a88888888;
	#25;
	diffusion_s[0] = 64'hcdfbd6b7955608b7;
	diffusion_s[1] = 64'hcd7e2fe9eb0ae45a;
	diffusion_s[2] = 64'h0f033a7f74f6ea47;
	diffusion_s[3] = 64'h10a6f3446c2bf588;
	diffusion_s[4] = 64'h014138bcb09639cf;
	#30;
     end // initial begin
endmodule : permitation_diffusion_tb
	
	
