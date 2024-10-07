`timescale 1ns/1ps

module toplevel import ascon_pack::*;
   (
    input logic clock_i,
    input logic resetb_i,
    input logic start_i,
    input logic data_valid_i,
    input logic [63:0] data_i,
    input logic [127:0] key_i,
    input logic [127:0] nonce_i,
    output logic [63:0] cipher_o,
    output logic [127:0] tag_o,
    output logic cipher_valid_o,
    output logic end_o
    );

   logic 	 enable_cpt_s, init_a_s, init_b_s, init_select_s, ena_xor_up_s, ena_xor_down_s, ena_reg_s, cipher_valid_s, end_s;
   logic [1:0] 	 conf_xor_down_s;
   logic [3:0] 	 counter_s;
   logic [255:0] data_xor_down_s;
   type_state permitation_o_s;
   type_state permitation_s ;
   type_state xor_up_s;
   logic [2:0] 	 cpt_s=3'b0;
   logic [63:0]  data_s;
   
   
   //initialisation de donnee
   assign permitation_s= {64'h80400c0600000000,key_i,nonce_i};

   //initialisation du composant FSM
   fsm_module fsm(
		  .resetb_fsm_i(resetb_i),
		  .clock_fsm_i(clock_i),
		  .start_fsm_i(start_i),
		  .data_valid_fsm_i(data_valid_i),
		  .round_i(counter_s),
		  .cipher_valid_fsm_o(cipher_valid_s),
		  .end_fsm_o(end_s),
		  .enable_cpt_o(enable_cpt_s),
		  .init_a_o(init_a_s),
		  .init_b_o(init_b_s),
		  .init_select_o(init_select_s),
		  .ena_xor_up_o(ena_xor_up_s),
		  .ena_xor_down_o(ena_xor_down_s),
		  .ena_reg_o(ena_reg_s),
		  .conf_xor_down_o(conf_xor_down_s)
		  );

   //initialisation du composant compteur de ronde
   cpt_module cpt(
		  .reset_i(resetb_i),
		  .clock_cpt_i(clock_i),
		  .enable_i(enable_cpt_s),
		  .init_a_i(init_a_s),
		  .init_b_i(init_b_s),
		  .counter_o(counter_s)
		  );

     //affectation de donnee pour xor down
      always_comb
	begin
          case(conf_xor_down_s)
	    2'b01 : begin
	       data_xor_down_s = {128'h0,key_i};
	    end
	    2'b10 : begin
	       data_xor_down_s = {255'h0,1'h1};
	    end
	    2'b11 : begin
	       data_xor_down_s =  {key_i,128'h0};
	    end
	    default : begin
	       data_xor_down_s = {128'h0,key_i};
	    end
	  endcase // case (conf_xor_down_s)
	end // always_comb

   //compteur de xor up
   always_comb begin
      if(ena_xor_up_s == 1'b1) cpt_s = cpt_s + 3'b1;
   end

   //affectation de data xor up selon le valeur du compteur
   always_comb begin
      case(cpt_s)
	3'b1: begin
	   data_s = data_i;
	end
	3'b10: begin
	   data_s = {64'h436f6e636576657a};
	end
	3'b11: begin
	   data_s = {64'h204153434f4e2065};
	end
	3'b100: begin
	   data_s = {64'h6e2053797374656d};
	end
	3'b101: begin
	   data_s = {64'h566572696c6f6780};
	end
      endcase // case (cpt_s)
   end // always_comb
   
	
   
   //initialisation du composant p xor
   permitation_xor perm(
			.clock_i(clock_i),
			.resetb_i(resetb_i),
			.select_i(init_select_s),
			.permutation_i(permitation_s),
			.roundp_i(counter_s),
			.data_xor_up_i(data_s),
			.data_xor_down_i(data_xor_down_s),
			.ena_xor_up_i(ena_xor_up_s),
			.ena_xor_down_i(ena_xor_down_s),
			.ena_reg_i(ena_reg_s),
			.permutation_o(permitation_o_s),
			.xor_up_o(xor_up_s)
			);

   //Les sorties du toplevel
   always_comb begin
      if(cipher_valid_s == 1'b1) cipher_o = xor_up_s[0];
      else cipher_o = 64'h0;
   end
   always_comb begin
      if(end_s == 1'b1) tag_o = {xor_up_s[3],xor_up_s[4]};
      else tag_o = 64'h0;
   end
   assign cipher_valid_o = cipher_valid_s;
   assign end_o = end_s;
  
endmodule : toplevel
   

   
		  
		  
		  

   
   
