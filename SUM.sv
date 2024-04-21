//Sumator 
module SUM(a, b, sum);
    input [15:0] a, b;
    //input carry_in;
    //output carry_out;
    output [15:0] sum;
  
    //assign sum = a ^ b ^ carry_in;
    //assign carry_out = ((a&b) | ((a^b) & carry_in)));
    //assign carry_out = (a & b) | (b & carry_in) | (carry_in & a);
    assign sum = a + b;
endmodule