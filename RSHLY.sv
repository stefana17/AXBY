//Registru shiftare stanga y
module RSHLY(clk, reset, ply, shifty, iny, outy);
    input clk, reset, ply, shifty;
    input [7:0] iny;
    output reg[15:0] outy;
    
    always @(posedge clk)
    if(reset)
        outy <= 16'b0;
    else
        if(ply)
            outy <= iny;
        else
            if(shifty)
                outy <= outy << 1;
    
endmodule