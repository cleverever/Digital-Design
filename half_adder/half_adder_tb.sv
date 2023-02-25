`timescale 1ns/1ns
module half_adder_tb;
logic in0, in1, sum, c_out;

half_adder design_instance
(
    .a(in0),
    .b(in1),
    .sum(sum),
    .c_out(c_out)
);

task automatic check(logic expected_sum, logic expected_c_out);
    $display("time=%0t   a=%1b   b=%1b   sum=%1b   c_out=%1b", $time, in0, in1, sum, c_out);
    if(sum == expected_sum && c_out == expected_c_out) begin
        $display("Correct\n\n\n");
    end
    else begin
        $display("Incorrect\nExpected:   sum=%1b   c_out=%1b\nActual:     sum=%1b   c_out=%1b\n", expected_sum, expected_c_out, sum, c_out);
    end
endtask

initial begin
in0=0;
in1=0;
#100;
check(0, 0);
in0=1;
in1=0;
#50;
check(1, 0);
in0=0;
in1=1;
#50;
check(1, 0);
in0=1;
in1=1;
#50;
check(0, 1);
end
endmodule