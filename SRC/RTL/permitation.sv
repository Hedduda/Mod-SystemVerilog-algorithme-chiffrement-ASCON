`timescale 1ns/1ps

module permitation import ascon_pack::*;
   (
    input logic clock_i,
    input logic resetb_i,
    input logic select_i,
    input type_state permutation_i,
    input logic [3:0] roundp_i,
    output type_state permutation_o
    );

   type_state state_pc;
   //multiplexeur pour selectionner l'entree
   assign state_pc = (select_i) ? permutation_i : permutation_o;

   type_state state_ps;
   //permutation constante
   permitation_constante pc(
			    .constante_add_i(state_pc),
			    .round_i(roundp_i),
			    .constante_add_o(state_ps)
			    );

   type_state state_pl;
   //permutation de substitution
   permitation_substitution ps(
			       .substitution_i(state_ps),
			       .substitution_o(state_pl)
			       );
   type_state state_p;
   //permutation de diffusion lineaire
   permitation_diffusion pl(
			    .diffusion_i(state_pl),
			    .diffusion_o(state_p)
			    );

   //registre de memorisation
   always @ (posedge clock_i, negedge resetb_i) begin
      if(resetb_i == 1'b0) begin
	 permutation_o <= {64'h0,64'h0,64'h0,64'h0,64'h0};
      end
      else begin
	 permutation_o <= state_p;
      end
   end
endmodule : permitation
   
   
