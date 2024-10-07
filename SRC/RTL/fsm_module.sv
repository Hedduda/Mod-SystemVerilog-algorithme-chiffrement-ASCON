`timescale 1ns/1ps

//fsm_moore
module fsm_module
  (
   input logic 	      clock_fsm_i,
   input logic 	      resetb_fsm_i,
   input logic 	      start_fsm_i,
   input logic 	      data_valid_fsm_i,
   input logic [3:0]  round_i,
   //input logic [2:0]	block_i,
   output logic       ena_reg_o,
   output logic       cipher_valid_fsm_o,
   output logic       end_fsm_o,
   output logic       init_select_o,
   output logic       enable_cpt_o,
   //output logic		ena_block_o,
   output logic       init_a_o,
   output logic       init_b_o,
   //output logic		init_block_o,
   output logic [1:0] conf_xor_down_o,
   output logic       ena_xor_up_o,
   output logic       ena_xor_down_o
   );

   //les etats du FSM
   typedef enum       {idle, set_cpt, initial_state, init, end_init, xor_a1, wait_a1,state1,end_state1,xor_p1,state2,end_state2,xor_p2,state3,end_state3,xor_p3,state4,end_state4,xor_p4,fin_state,end_fin_state,fin} fsm_state;

   //variables internes
   fsm_state current_state_s, next_state_s;

   // Sequentiel : memorise l'état courant
   always @(posedge clock_fsm_i, negedge resetb_fsm_i) begin
      if (resetb_fsm_i == 1'b0) begin
	 current_state_s <= idle;
      end
      else begin
	 current_state_s <= next_state_s;
      end
   end

   // Combinatoire : transition d'état f (curren-_state, entree)
   always_comb begin
      case(current_state_s)
        idle: 
          if (start_fsm_i == 1'b1)
            next_state_s = set_cpt;
          else
            next_state_s = idle;
        set_cpt:
	  next_state_s = initial_state;
        initial_state:
          next_state_s = init;
	init:
	  if (round_i == 4'hA)
	    next_state_s = end_init;
          else
            next_state_s = init;
        end_init:
          if (data_valid_fsm_i == 1'b1)
            next_state_s = xor_a1;
          else begin
             next_state_s   = wait_a1;
	  end
        xor_a1:
          next_state_s = state1;
	wait_a1 :
	  if (data_valid_fsm_i == 1'b1)
            next_state_s = xor_a1;
          else begin
             next_state_s   = wait_a1;
	  end
	state1:
	  if (round_i == 4'hA)
	    next_state_s = end_state1;
          else
            next_state_s = state1;
	end_state1:
          next_state_s = xor_p1;
	xor_p1:
	  next_state_s = state2;
	state2:
	  if (round_i == 4'hA)
	    next_state_s = end_state2;
          else
            next_state_s = state2;
	end_state2:
          next_state_s = xor_p2;
	xor_p2:
	  next_state_s = state3;
	state3:
	  if (round_i == 4'hA)
	    next_state_s = end_state3;
          else
            next_state_s = state3;
	end_state3:
          next_state_s = xor_p3;
	xor_p3:
	  next_state_s = state4;
	state4:
	  if (round_i == 4'hA)
	    next_state_s = end_state4;
          else
            next_state_s = state4;
	end_state4:
          next_state_s = xor_p4;
	xor_p4:
	  next_state_s = fin_state;
	fin_state:
	  if (round_i == 4'hA)
	    next_state_s = end_fin_state;
          else
            next_state_s = fin_state;
	end_fin_state:
            next_state_s = fin;
	fin:
	  next_state_s = idle;
      endcase // case (current_state_s)
   end

   // Combinatoire des sorties
   always_comb begin
      cipher_valid_fsm_o  = 1'b0;
      end_fsm_o           = 1'b0;
      init_select_o    = 1'b0;
      enable_cpt_o        = 1'b0;
      init_a_o        = 1'b0;
      init_b_o        = 1'b0;
      //init_block_o    = 1'b0;
      //ena_block_o  = 1'b0;
      ena_xor_up_o    = 1'b0;
      ena_xor_down_o  = 1'b0;
      conf_xor_down_o = 2'b00;
      ena_reg_o = 1'b0;

      case(current_state_s)
        idle : begin
           // NOP
	end
        set_cpt: begin
           init_a_o = 1'b1;
	   enable_cpt_o = 1'b1;
	end
        initial_state: begin
	   init_select_o = 1'b1;
           enable_cpt_o     = 1'b1;
           ena_reg_o = 1'b1;
	end
        init: begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_init: begin
	   ena_xor_down_o = 1'b1;
	   init_b_o       = 1'b1;
	   enable_cpt_o       = 1'b1;
	   ena_reg_o = 1'b1;
	   conf_xor_down_o = 2'b01;
	end
	xor_a1: begin
	   enable_cpt_o     = 1'b1;
	   ena_xor_up_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	wait_a1 : begin
	   enable_cpt_o     = 1'b0;
	   ena_reg_o = 1'b0;
	end
	state1 : begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_state1 : begin
	   ena_xor_down_o = 1'b1;
	   conf_xor_down_o = 2'b10;
	   init_b_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	xor_p1 : begin
	   ena_xor_up_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	   cipher_valid_fsm_o = 1'b1;
	end
	state2 : begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_state2 : begin
	   ena_xor_down_o = 1'b0;
	   init_b_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	xor_p2 : begin
	   ena_xor_up_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	   cipher_valid_fsm_o = 1'b1;
	end
	state3 : begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_state3 : begin
	   ena_xor_down_o = 1'b0;
	   init_b_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	xor_p3 : begin
	   ena_xor_up_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	   cipher_valid_fsm_o = 1'b1;
	end
	state4 : begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_state4 : begin
	   ena_xor_down_o = 1'b1;
	   conf_xor_down_o = 2'b11;
	   init_b_o = 1'b0;
	   init_a_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	xor_p4 : begin
	   ena_xor_up_o = 1'b1;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	   cipher_valid_fsm_o = 1'b1;
	end
	fin_state : begin
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	end_fin_state : begin
	   ena_xor_down_o = 1'b1;
	   conf_xor_down_o = 2'b01;
	   init_b_o = 1'b0;
	   init_a_o = 1'b0;
	   enable_cpt_o = 1'b1;
	   ena_reg_o = 1'b1;
	end
	fin : begin
	   end_fsm_o = 1'b1;
	end
      endcase
   end 
endmodule : fsm_module
