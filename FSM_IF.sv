//Interfata
module FSM_IF(clk, reset, WR, RD, SETRDYP, PLx, PLy, START, RDYP, OEH, OEL);
  
  input clk, reset;
  input WR, RD, SETRDYP;
  
  output reg PLx, PLy, START, RDYP, OEH, OEL;
  
  reg [3:0] cs, ns;
  
  localparam S0  = 4'b0000;
  localparam S1  = 4'b0001;
  localparam S2  = 4'b0010;
  localparam S3  = 4'b0011;
  localparam S4  = 4'b0100;
  localparam S5  = 4'b0101;
  localparam S6  = 4'b0110;
  localparam S7  = 4'b0111;
  localparam S8  = 4'b1000;
  localparam S9  = 4'b1001;
  localparam S10 = 4'b1010;
  
  
  always @(posedge clk or posedge reset)
    if(reset) 
      cs <= 4'b0;
  	else
      cs <= ns; //actualizare stare curenta
  
  always @(cs or WR or RD or SETRDYP)
    casex({cs, WR, RD, SETRDYP})
      
      //S0
      7'b0000_0_x_x: ns = S0;
      7'b0000_1_x_x: ns = S1;
      
      //S1
      7'b0001_0_x_x: ns = S3;
      7'b0001_1_x_x: ns = S2;
      
      //S2
      7'b0010_0_x_x: ns = S3;
      7'b0010_1_x_x: ns = S2;
      
      //S3
      7'b0011_0_x_x: ns = S3;
      7'b0011_1_x_x: ns = S4;
      
      //S4
      7'b0100_0_x_x: ns = S6;
      7'b0100_1_x_x: ns = S5;
      
      //S5
      7'b0101_0_x_x: ns = S6;
      7'b0101_1_x_x: ns = S5;
      
      //S6
      7'b0110_x_x_0: ns = S6;
      7'b0110_x_x_1: ns = S7;
      
      //S7
      7'b0111_x_0_x: ns = S7;
      7'b0111_x_1_x: ns = S8;
      
      //S8
      7'b1000_x_0_x: ns = S9;
      7'b1000_x_1_x: ns = S8;
      
      //S9
      7'b1001_x_0_x: ns = S9;
      7'b1001_x_1_x: ns = S10;
      
      //S10
      7'b1010_x_0_x: ns = S0;
      7'b1010_x_1_x: ns = S10;
      
      default: ns = S0;
      
    endcase
           
  always @(cs)
    case(cs)
      
      4'b0000: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b000000;
      4'b0001: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b100000;
      4'b0010: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b000000;
      4'b0011: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b000000;
      4'b0100: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b010000;
      4'b0101: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b000000;
      4'b0110: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b001000;
      4'b0111: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b001100;
      4'b1000: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b001110;
      4'b1001: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b001100;
      4'b1010: {PLx, PLy, START, RDYP, OEH, OEL} = 6'b001101;
      
    endcase
  
  
endmodule