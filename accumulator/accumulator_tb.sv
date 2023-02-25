`timescale 1ns/1ns
module accumulator_tb;
parameter N = 16;
logic[N-1:0] in;
logic[N-1:0] out;
logic[N-1:0] expected_out;
logic clock;
logic reset;

accumulator #(.N(N)) design_instance
(
    .clock(clock),
    .reset(reset),
    .in(in),
    .out(out)
);

always_ff @(posedge clock, posedge reset) begin
    if(reset) begin
        expected_out <= 0;
    end
    else begin
        expected_out <= expected_out + in;
    end
end

task automatic check();
    $display("time=%0t   in=%d   reset=%d   out=%d", $time, in, reset, out);
    if(out == expected_out) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   out=%d\nActual:     out=%d\n", expected_out, out);
    end
endtask

initial begin
clock=0;
reset=1;
in=0;
#40ns;
check();

reset=0;
in=1;
#20ns;
check();
reset=0;
in=1;
#20ns;
check();
reset=0;
in=3;
#20ns;
check();
reset=0;
in=49;
#20ns;
check();
reset=0;
in=127;
#20ns;
check();
reset=0;
in=7;
#20ns;
check();
reset=0;
in=34;
#20ns;
check();
reset=1;
in=34;
#20ns;
check();
reset=1;
in=23;
#20ns;
check();

$finish();
end

always@(clock) begin
  #10ns clock <= !clock;
end
endmodule