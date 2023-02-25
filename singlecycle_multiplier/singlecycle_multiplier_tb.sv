`timescale 1ns/1ns
module singlecycle_multiplier_tb;
parameter N = 8;
logic[N-1:0] in0;
logic[N-1:0] in1;
logic[(N*2)-1:0] result;

singlecycle_multiplier #(.N(N)) design_instance
(
    .in0(in0),
    .in1(in1),
    .result(result)
);

task automatic check(logic[(N*2)-1:0] expected_result);
    $display("time=%0t   a=%d   b=%d   result=%d", $time, in0, in1, result);
    if(result == expected_result) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   result=%d   \nActual:     result=%d\n", expected_result, result);
    end
endtask

initial begin
in0=0;
in1=0;
#100;
check(0);
in0=7;
in1=7;
#50;
check(49);
in0=128;
in1=128;
#50;
check(16384);
end
endmodule