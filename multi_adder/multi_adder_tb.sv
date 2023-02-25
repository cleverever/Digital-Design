`timescale 1ns/1ns
module multi_adder_tb;
parameter N = 8;
parameter NUM_OPS = 8;
logic[N-1:0] in[NUM_OPS-1:0];
logic[N-1+$clog2(NUM_OPS):0] sum;

multi_adder #(.N(N), .NUM_OPS(NUM_OPS)) design_instance
(
    .in(in),
    .sum(sum)
);

task automatic check(logic[N-1+$clog2(NUM_OPS):0] expected_sum);
    $display("time=%0t", $time);
    foreach(in[i]) begin
        if(i == N-1) begin
            $display(" %d", in[i]);
        end
        else begin
            $display("+%d", in[i]);
        end
    end
    $display("\nsum=%d", sum);
    if(sum == expected_sum) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   sum=%d\nActual:     sum=%d\n", expected_sum, sum);
    end
endtask

initial begin
in={0, 0, 0, 0, 0, 0, 0, 0};
#100;
check(0);
in={1, 1, 1, 1, 1, 1, 1, 1};
#50;
check(8);
in={13, 7, 64, 38, 21, 78, 93, 45};
#50;
check(359);
end
endmodule