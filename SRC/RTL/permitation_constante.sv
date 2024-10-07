`timescale 1ns/1ps

module permitation_constante import ascon_pack::*;
(
input type_state constante_add_i,
input logic[3:0] round_i,
output type_state constante_add_o
 );
   //recuperation des sorties avec modification sur le registre 2 de l'etat S en appliquant xor avec la valeur de la ronde recuperee du package
   assign constante_add_o[0] = constante_add_i[0];
   assign constante_add_o[1] = constante_add_i[1];
   assign constante_add_o[2][7:0] = constante_add_i[2][7:0] ^ round_constant[round_i];
   assign constante_add_o[2][63:8] = constante_add_i[2][63:8];
   assign constante_add_o[3] = constante_add_i[3];
   assign constante_add_o[4] = constante_add_i[4];

endmodule: permitation_constante
