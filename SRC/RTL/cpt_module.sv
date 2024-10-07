module cpt_module
	(
	 input logic		clock_cpt_i,
	 input logic		reset_i,
	 input logic		enable_i,
	 input logic		init_a_i,
	 input logic		init_b_i,
	 output logic [3:0]	counter_o
	 );

	logic [3:0]			count_s;

        //processus sequentiel pour le compteur
	always @(posedge clock_cpt_i, negedge reset_i) begin
		if (reset_i == 1'b0) begin
			count_s <= 0;
		end
		else begin
		        //si le compteur est active le compteur
			if (enable_i == 1'b1) begin
			        //permutation p12
				if (init_a_i == 1'b1)
					count_s <= 0;
			        //pernutation p6
				else if (init_b_i == 1'b1)
					count_s <= 6;
				else
					count_s <= count_s + 1;
			end
		end
	end // always @ (posedge clock_i, negedge resetb_i)

        //valeur de la ronde
	assign counter_o = count_s;
	
endmodule // cpt_module
