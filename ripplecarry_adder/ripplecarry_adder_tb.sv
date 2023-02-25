`timescale 1ns/1ns
module ripplecarry_adder_tb;
parameter N = 8;
logic[N-1:0] in0, in1;
logic c_in;
logic[N-1:0] sum;
logic c_out;

ripplecarry_adder #(.N(N)) design_instance
(
    .a(in0),
    .b(in1),
    .c_in(c_in),
    .sum(sum),
    .c_out(c_out)
);

task automatic check(logic[N:0] expected_sum);
    $display("time=%0t   a=%d   b=%d   c_in=%d   sum=%d   c_out=%d", $time, in0, in1, c_in, sum, c_out);
    if(sum == expected_sum[N-1:0] && c_out == expected_sum[N]) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   sum=%d   c_out=%d\nActual:     sum=%d   c_out=%d\n", expected_sum[N-1:0], expected_sum[N], sum, c_out);
    end
endtask

initial begin
in0=0;
in1=0;
c_in=0;
#100;
check(0);
in0=0;
in1=0;
c_in=1;
#50;
check(1);
in0=63;
in1=1;
c_in=0;
#50;
check(64);
in0=95;
in1=0;
c_in=1;
#50;
check(96);
in0=3;
in1=12;
c_in=1;
#50;
check(16);
in0=255;
in1=1;
c_in=0;
#50;
check(256);
in0=255;
in1=255;
c_in=1;
#50;
check(511);
end
endmodule