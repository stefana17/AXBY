//Mux 2in1
module MUX2_1(a, b, sel, z);
    input [15:0] a, b;
    input sel;
    output[15:0] z;
    
    assign z = sel ? b : a;
endmodule