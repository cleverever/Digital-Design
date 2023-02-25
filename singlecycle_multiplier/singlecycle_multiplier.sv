//`include "multi_adder.sv"
module singlecycle_multiplier#(parameter N=8)
(
    input logic[N-1:0] in0,
    input logic[N-1:0] in1,
    output logic[(2*N)-1:0] result
);

logic[(2*N)-1:0] to_add[N-1:0];

multi_adder #(.N((2*N)), .NUM_OPS(N)) ma
(
    .in(to_add),
    .sum(result)
);

generate
    genvar i;
    for(i = 0; i < N; i++) begin: add
        assign to_add[i] = (in1[i])? {in0, {i{1'b0}}} : 0;
    end: add
endgenerate
endmodule