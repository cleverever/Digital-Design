`timescale 1ns/1ns
module accumulator_multiplier_tb;
parameter N = 32;
logic[N-1:0] in0;
logic[N-1:0] in1;

logic[N*2-1:0] out;
logic done;
logic[N-1:0] expected_out;

logic clock;
logic reset;

assign expected_out = in0 * in1;

accumulator_multiplier #(.N(N)) design_instance
(
    .clock(clock),
    .reset(reset),
    .multiplicand(in0),
    .multiplier(in1),
    .out(out),
    .done(done)
);

task automatic check();
    $display("time=%0t   in0=%d   in1=%d   reset=%d   out=%d", $time, in0, in1, reset, out);
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
in0=0;
in1=0;
#40ns;

reset=0;
in0=0;
in1=0;
wait(done);
check();

#20ns;
reset=1;
#20ns;
reset=0;
in0=1;
in1=1;
wait(done);
check();

#20ns;
reset=1;
#20ns;
reset=0;
in0=7;
in1=7;
wait(done);
check();

#20ns;
reset=1;
#20ns;
reset=0;
in0=134;
in1=79;
wait(done);
check();

#20ns;
reset=1;
#20ns;
reset=0;
in0=127;
in1=127;
wait(done);
check();

$finish();
end

always@(clock) begin
  #10ns clock <= !clock;
end
endmodule