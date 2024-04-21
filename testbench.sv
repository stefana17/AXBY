// Code your testbench here
// or browse Examples
/*module Testbench_AXBY;

  //Parametrii de timp
  parameter PERIOD = 10; //Perioada semnalului de ceas
  parameter HALF_PERIOD = PERIOD / 2; //Jumatate din perioada semnalului de ceas

  //Semnale pentru testbench
  reg clk, reset, plx, ply, shiftx, shifty, sel, incxy, plrez;
  reg [7:0] inx, iny;
  reg [15:0] a, b;
  wire [15:0] result;

  //Instantierea modulului AXBY
  AXBY uut (
    .clk(clk),
    .reset(reset),
    .plx(plx),
    .ply(ply),
    .shiftx(shiftx),
    .shifty(shifty),
    .sel(sel),
    .incxy(incxy),
    .plrez(plrez),
    .inx(inx),
    .iny(iny),
    .a(a),
    .b(b),
    .result(result)
  );

  //Generarea semnalului de ceas
  always begin
    #HALF_PERIOD clk = ~clk;
  end

  //Initializare semnale
  initial begin
    clk = 0;
    reset = 1;
    plx = 0;
    ply = 0;
    shiftx = 0;
    shifty = 0;
    sel = 0;
    incxy = 0;
    plrez = 0;
    inx = 8'b00000000;
    iny = 8'b00000000;
    a = 8'b01000100; //68 in binar
    b = 8'b10000000; //128 in binar

    //Aplic un reset
    #PERIOD reset = 0;

    //Valori + stimuli pentru test
    #PERIOD inx = 8'b01010101; //x random
    #PERIOD iny = 8'b10101010; //y random
    #PERIOD plx = 1;
    #PERIOD plx = 0;
    #PERIOD shiftx = 1;
    #PERIOD shiftx = 0;
    #PERIOD ply = 1;
    #PERIOD ply = 0;
    #PERIOD shifty = 1;
    #PERIOD shifty = 0;
    #PERIOD sel = 1; //Aleg b
    #PERIOD sel = 0; //Aleg a
    #PERIOD incxy = 1;
    #PERIOD incxy = 0;
    #PERIOD plrez = 1;
    #PERIOD plrez = 0;

    //Rezultatul
    #PERIOD $finish;
  end
  
  /*initial
    #220 $finish;*/
  
 /* initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, MIPS_inst);
    end

endmodule*/
