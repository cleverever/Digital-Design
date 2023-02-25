`timescale 1ns/1ns
module carrysave_adder_tb;
parameter N = 8;
logic[N-1:0] in0, in1, in2;
logic[N-1:0] sum, carry;

carrysave_adder #(.N(N)) design_instance
(
    .a(in0),
    .b(in1),
    .c(in2),
    .sum(sum),
    .carry(carry)
);

task automatic check(logic[N-1:0] expected_sum, logic[N-1:0] expected_carry);
    $display("time=%0t   a=%d   b=%d   c=%d   sum=%d   carry=%d", $time, in0, in1, in2, sum, carry);
    if(sum == expected_sum && carry == expected_carry) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   sum=%d   carry=%d\nActual:     sum=%d   carry=%d\n", expected_sum, expected_carry, sum, carry);
    end
endtask

initial begin
in0=0;
in1=0;
in2=0;
#100;
check(0, 0);
in0=5;
in1=5;
in2=0;
#50;
check(0, 5);
in0=5;
in1=5;
in2=5;
#50;
check(5, 5);
in0=7;
in1=9;
in2=4;
#50;
check(10, 5);
in0=255;
in1=255;
in2=0;
#50;
check(0, 255);
in0=255;
in1=255;
in2=255;
#50;
check(255, 255);
end
endmodule