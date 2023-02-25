module abs_unit#(parameter N=8)
(
    input logic in,
    output logic out
);

carrylookahead_adder #(.N(4), .LEVELS(CLA_LEVELS)) cla
(
    .a(in),
    .b(temp_sum[L][1]),
    .c_in(0),
    .sum(cla_sum[4**CLA_LEVELS-1:0]),
    .c_out(cla_sum[4**CLA_LEVELS])
);
endmodule