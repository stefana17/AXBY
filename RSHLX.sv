//Registru shiftare stanga x
module RSHLX(clk, reset, plx, shiftx, inx, outx);
    input clk, reset, plx, shiftx;
    input [7:0] inx;
    output reg[15:0] outx;
    
    always @(posedge clk)
    if(reset)
        outx <= 16'b0;
    else
        if(plx)
            outx <= inx;
        else
            if(shiftx)
                outx <= outx << 1;
    
endmodule