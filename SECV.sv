//Secventiator
module SECV(clk, START, SETRDYP, CMD, STATUS);

  input clk, START;
  input [4:0] STATUS;

  output reg SETRDYP;
  output reg [7:0] CMD; //resi, plx, shlx, ply, shly, plrez, inc, sel

  reg [4:0] cs, ns;

  localparam S0  = 5'b00000;
  localparam S1  = 5'b00001;
  localparam S2  = 5'b00010;
  localparam S3  = 5'b00011;
  localparam S4  = 5'b00100;
  localparam S5  = 5'b00101;
  localparam S6  = 5'b00110;
  localparam S7  = 5'b00111;
  localparam S8  = 5'b01000;
  localparam S9  = 5'b01001;
  localparam S10 = 5'b01010;
  localparam S11 = 5'b01011;
  localparam S12 = 5'b01100;
  localparam S13 = 5'b01101;
  localparam S14 = 5'b01110;
  localparam S15 = 5'b01111;
  localparam S16 = 5'b10000;
  localparam S17 = 5'b10001;
  localparam S18 = 5'b10010;
  localparam S19 = 5'b10011;
  localparam S20 = 5'b10100;
  localparam S21 = 5'b10101;
  localparam S22 = 5'b10110;
  localparam S23 = 5'b10111;
  localparam S24 = 5'b11000;

  always@(posedge clk)
    cs <= ns; //actualizare stare curenta
  
  //STATUS -> Cond: (x = 0), (y = 0), (i = 2), (i = 6), (i = 7)
  always @(cs or START or STATUS)
    casex({cs, START, STATUS})
      //S0
      11'b00000_0_xxxxx: ns = S0;
      11'b00000_1_xxxxx: ns = S1;

      //S1
      11'b00001_x_xxxxx: ns = S2;

      //S2
      11'b00010_x_0xxxx: ns = S3;
      11'b00010_x_1xxxx: ns = S20;

      //S3
      11'b00011_x_x0xxx: ns = S4;
      11'b00011_x_x1xxx: ns = S14;
      
      //S4
      11'b00100_x_xxxxx: ns = S5;

      //S5
      11'b00101_x_xx0xx: ns = S4;
      11'b00101_x_xx1xx: ns = S6;

      //S6
      11'b00110_x_xxxxx: ns = S7;

      //S7
      11'b00110_x_xxxxx: ns = S8;
      
      //S8
      11'b01000_x_xxx0x: ns = S7;
      11'b01000_x_xxx1x: ns = S9;
      
      //S9
      11'b01001_x_xxxxx: ns = S10;
      
      //S10
      11'b01010_x_xxxxx: ns = S11;
      
      //S11
      11'b01011_x_xxxx0: ns = S10;
      11'b01011_x_xxxx1: ns = S12;
      
      //S12
      11'b01100_x_xxxxx: ns = S13;
      
      //S13
      11'b01101_x_xxxxx: ns = S14;
      
      //S14
      11'b01110_1_xxxxx: ns = S14;
      11'b01110_0_xxxxx: ns = S0;
      
      //S15
      11'b01111_x_xxxxx: ns = S16;

      //S16
      11'b10000_x_xx0xx: ns = S15;
      11'b10000_x_xx1xx: ns = S17;

      //S17
      11'b10001_x_xxxxx: ns = S18;

      //S18
      11'b10010_x_xxxxx: ns = S19;

      //S19
      11'b10011_x_xxx0x: ns = S18;
      11'b10011_0_xxx1x: ns = S20;
      
      //S20
      11'b10100_x_xxxxx: ns = S13;
      
      //S21
      11'b10101_x_x0xxx: ns = S22;
      11'b10101_x_x1xxx: ns = S13;
      
      //S22
      11'b10110_x_xxxxx: ns = S23;
      
      //S23
      11'b10111_x_xxxx0: ns = S22;
      11'b10111_x_xxxx1: ns = S24;
      
      //S24
      11'b11000_x_xxxx0: ns = S13;
      
      default:
        ns = S0;
	
    endcase
  //CMD -> resi, plx, shlx, ply, shly, plrez, inc, sel
  always @(cs)
    case(cs)
      //S1 
      S1: CMD = 8'b1_0_0_0_0_0_0_0;
      //S4
      S4: CMD = 8'b0_0_1_0_0_0_1_0;
      //S6
      S6: CMD = 8'b0_0_0_0_0_1_0_0;
      //S7
      S7: CMD = 8'b0_0_1_0_0_0_1_0;
      //S9
      S9: CMD = 8'b0_0_0_0_0_1_0_0;
      //S10
      S10: CMD = 8'b0_0_0_0_1_0_1_0;
      //S12
      S12: CMD = 8'b0_0_0_0_0_1_0_1;
      //S15
      S15: CMD = 8'b0_0_1_0_0_0_1_0;
      //S17
      S17: CMD = 8'b0_0_0_0_0_1_0_0;
      //S18
      S18: CMD = 8'b0_0_1_0_0_0_1_0;
      //S20
      S20: CMD = 8'b0_0_0_0_0_1_0_0;
      //S22
      S22: CMD = 8'b0_0_0_0_1_0_1_0;
      //S24
      S24: CMD = 8'b0_0_0_0_0_1_0_1;
      //S13
      S13: 
        begin
          CMD = 8'b0;
          SETRDYP = 1'b0;
        end
      //S14
      S14: CMD = 8'b1_0_0_0_0_0_0_0;
      default:
        begin
          CMD = 8'b0;
          SETRDYP = 1'b0;
        end
    endcase

endmodule