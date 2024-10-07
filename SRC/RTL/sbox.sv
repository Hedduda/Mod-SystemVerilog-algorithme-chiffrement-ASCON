`timescale 1ns/1ps

module sbox (
	     input logic[4:0] sbox_i,
	     output logic[4:0] sbox_o
	     );

   //declarer la table de substitution a appliquer sur l'etat S
   always_comb
     begin
	case (sbox_i)
	  5'h00 : sbox_o = 5'h04;
	  5'h01 : sbox_o = 5'h0b;
	  5'h02 : sbox_o = 5'h1f;
	  5'h03 : sbox_o = 5'h14;
	  5'h04 : sbox_o = 5'h1a;
	  5'h05 : sbox_o = 5'h15;
	  5'h06 : sbox_o = 5'h09;
	  5'h07 : sbox_o = 5'h02;
	  5'h08 : sbox_o = 5'h1b;
	  5'h09 : sbox_o = 5'h05;
	  5'h0a : sbox_o = 5'h08;
	  5'h0b : sbox_o = 5'h12;
	  5'h0c : sbox_o = 5'h1d;
	  5'h0d : sbox_o = 5'h03;
	  5'h0e : sbox_o = 5'h06;
	  5'h0f : sbox_o = 5'h1c;
	  5'h10 : sbox_o = 5'h1e;
	  5'h11 : sbox_o = 5'h13;
	  5'h12 : sbox_o = 5'h07;
	  5'h13 : sbox_o = 5'h0e;
	  5'h14 : sbox_o = 5'h00;
	  5'h15 : sbox_o = 5'h0d;
	  5'h16 : sbox_o = 5'h11;
	  5'h17 : sbox_o = 5'h18;
	  5'h18 : sbox_o = 5'h10;
	  5'h19 : sbox_o = 5'h0C;
	  5'h1A : sbox_o = 5'h01;
	  5'h1B : sbox_o = 5'h19;
	  5'h1C : sbox_o = 5'h16;
	  5'h1D : sbox_o = 5'h0A;
	  5'h1E : sbox_o = 5'h0F;
	  5'h1F : sbox_o = 5'h17;
	endcase // case (sbox_i)
     end // always_comb
endmodule : sbox
	  
	  
