//Counter
module COUNTERXY(clk, reset, incxy, cnt_2, cnt_6, cnt_7);
    input clk, reset, incxy;
    output cnt_2, cnt_6, cnt_7;
    reg [2:0] cnt_int;
    
    always @(posedge clk)
        if(reset)
            cnt_int <= 3'b0;
        else
            if(incxy)
                cnt_int <= cnt_int + 1;
    assign cnt_2 = (cnt_int == 3'b010);
    assign cnt_6 = (cnt_int == 3'b110);
    assign cnt_7 = (cnt_int == 3'b111);
endmodule