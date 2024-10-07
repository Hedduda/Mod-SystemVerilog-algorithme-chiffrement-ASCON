`timescale 1ns/1ps

module permitation_substitution import ascon_pack::*;
   (
    input type_state substitution_i,
    output type_state substitution_o
    );

   genvar  i;

   //generer sur 64 colonnes des regitres de l'etat S
   generate
      for (i=0; i<64; i++)
	begin : label1
	   //generer avec la structure for pour le composant sbox
	   sbox sbox_u (
			.sbox_i({substitution_i[0][i],substitution_i[1][i],substitution_i[2][i],substitution_i[3][i],substitution_i[4][i]}),
			.sbox_o({substitution_o[0][i],substitution_o[1][i],substitution_o[2][i],substitution_o[3][i],substitution_o[4][i]})
			);
	end
   endgenerate
endmodule : permitation_substitution
