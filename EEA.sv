`include "RSHLX.sv"
`include "RSHLY.sv"
`include "MUX2_1.sv"
`include "COUNTERXY.sv"
`include "REGREZ.sv"
`include "SUM.sv"

module EEA(
    input clk, reset, plx, ply, shiftx, shifty, sel, incxy, plrez,
    input [7:0] inx, iny,
  	input [7:0] a, b,
  	output [15:0] result,
    output [4:0] Status
);

    wire [15:0] outx, outy;
    wire [15:0] z;
    wire [15:0] sum;
    wire [15:0] dorez;
    
    RSHLX RSHLX_inst(.clk(clk), .reset(reset), .plx(plx), .shiftx(shiftx), .inx(inx), .outx(outx));
    RSHLY RSHLY_inst(.clk(clk), .reset(reset), .ply(ply), .shifty(shifty), .iny(iny), .outy(outy));
    
    MUX2_1 MUX2_1_inst(.a(outx), .b(outy), .sel(sel), .z(z)); 
    SUM SUM_inst(.a(z), .b(dorez), .sum(sum));
    REGREZ REGREZ_inst(.clk(clk), .reset(reset), .plrez(plrez), .direz(sum), .dorez(dorez));
    
    COUNTERXY COUNTERXY_inst(.clk(clk), .reset(reset), .incxy(incxy), .cnt_2(), .cnt_6(), .cnt_7());
    
    //Adaug valorile a si b la rezultat
    assign result = dorez + (COUNTERXY_inst.cnt_6 ? a : b);

endmodule