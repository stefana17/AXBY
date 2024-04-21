// Code your design here
`include "SECV.sv"
`include "EEA.sv"
`include "FSM_IF.sv"

module one_Period(clk, reset, in, out);
    
  input clk, reset, in;
  output out;
  
  reg [1:0] cs, ns;
  
  always@ (posedge clk)
    if(reset)
      cs <= 2'b00;
  	else
      cs <= ns;
  
  assign out = (cs == 2'b01);
  
  always@ (cs or in)
    casex({cs, in})
      3'b00_0: ns = 2'b00;
      3'b00_1: ns = 2'b01;
      3'b01_0: ns = 2'b00;
      3'b01_1: ns = 2'b10;
      3'b10_0: ns = 2'b00;
      3'b10_1: ns = 2'b10;
      default:
        ns = 2'b00;
    endcase
    
endmodule

module sync(clk, reset, in, out);
  input clk, reset, in;
  output reg out;
  reg c;
  always @(posedge clk)
    if(reset)
      begin
        c <= 1'b0;
        out <= 1'b0;
      end
  else
    begin 
      c <= in;
      out <= c;
    end
endmodule

module TOP(
  input clk, reset, WR_b, RD_b,
  input [7:0] inx, iny,
  output RDYP,
  output [15:0] dataOut);
  
  wire [6:0] IF_Out;
  wire [7:0] CMD_Out;
  wire [4:0] STATUS_Out;
  wire shlX, shlY, plReg, inc, sel;
  
  wire START, SETRDYP, PL1, PL2, OE1, OE2;
  
  assign START = IF_Out[0];
  assign RDYP = IF_Out[1];
  assign PL1 = IF_Out[3];
  assign PL2 = IF_Out[4];
  assign OE1 = IF_Out[5];
  assign OE2 = IF_Out[6];
  
  FSM_IF FSM_IF_inst(.clk(clk), .reset(reset), .WR(WR_b), .RD(RD_b), .SETRDYP(SETRDYP), .PLx(PL1), .PLy(PL2), .START(START), .RDYP(RDYP), .OEH(OE1), .OEL(OE2));
  EEA EEA_inst(.clk(clk), .reset(reset), .plx(PL1), .ply(PL2), .shiftx(shlX), .shifty(shlY), .sel(sel), .incxy(inc), .plrez(plReg), .inx(inx), .iny(iny), .a(8'b01000100), .b(8'b10000000), .result(dataOut), .Status(STATUS_Out));
  SECV SECV_inst(.clk(clk), .START(START), .SETRDYP(SETRDYP), .CMD(CMD_Out), .STATUS(STATUS_Out));
  
  
endmodule
