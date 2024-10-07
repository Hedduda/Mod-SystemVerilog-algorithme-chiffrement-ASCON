`timescale 1ns/1ps

module toplevel_tb import ascon_pack::*; ();

   // inputs for ASCON
   logic 	  clock_s = 1'b0;
   logic 	  resetb_s, start_s;
   logic [63:0]   data_s;
   logic 	  data_valid_s;
   logic [127:0]  key_s;
   logic [127:0]  nonce_s;

   // outputs of ASCON
   logic [63:0]   cipher_s;
   logic 	  cipher_valid_s;
   logic [127:0]  tag_s;
   logic 	  end_s;

   toplevel DUT
     (
      .clock_i(clock_s),
      .resetb_i(resetb_s),
      .start_i(start_s),
      .data_i(data_s),
      .data_valid_i(data_valid_s),
      .key_i(key_s),
      .nonce_i(nonce_s),
      .cipher_o(cipher_s),
      .cipher_valid_o(cipher_valid_s),
      .tag_o(tag_s),
      .end_o(end_s)
      );
   
   // Clock generation
   initial begin : clock_gen
      forever #10 clock_s = ~ clock_s;
   end

   //test du toplevel
   initial begin : main

      key_s = 128'h000102030405060708090a0b0c0d0e0f;
      nonce_s = 128'h00112233445566778899aabbccddeeff;

      resetb_s   = 1'b0;
      start_s = 1'b0;
      data_valid_s = 1'b0;
      data_s = 64'h0;

      #50;

      resetb_s   = 1'b1;
      #20;

      start_s = 1'b1;
      data_s = {32'h32303233,32'h80000000};
      data_valid_s = 1'b1;
      #20;

      data_valid_s = 1'b0;
      #20;

      data_valid_s = 1'b1;
      
      #20;
      
      start_s=1'b0;

   end
endmodule
