module frequencyDivisor;

reg clk,reset;
wire clk_out;
 
frequency_divisor #(.WIDTH(3), .N(3))
FD1(
.clk(clk),
.reset(reset),
.out_clk(clk_out)
);

initial clk= 1'b0;

always #5  clk=~clk; 
        
initial
    begin
        //reset=1'b1;
        //#5
        //reset=1'b0;
        #500 
        $stop;
    end
 
initial $monitor("clk=%b,reset=%b,clk_out=%b",clk,reset,clk_out);
endmodule