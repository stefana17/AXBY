//Registru Rezultat
module REGREZ(clk, reset, plrez, direz, dorez);
    input clk, reset, plrez;
    input [15:0] direz;
    output reg [15:0] dorez;
    
    always @(posedge clk)
        if(reset)
			dorez <= 16'b0;
		else
			if(plrez)
				dorez <= direz;
endmodule