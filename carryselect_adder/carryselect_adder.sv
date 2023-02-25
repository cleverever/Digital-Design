//`include "ripplecarry_adder.sv"
module carryselect_adder#(parameter N=32, M=8)
(
    input logic[N-1:0] a, b,
    input logic c_in,
    output logic[N-1:0] sum,
    output logic c_out
);

logic[N/M:0] carry;
logic[N/M-1:0] carry0;
logic[N/M-1:0] carry1;
assign carry[0] = c_in;
assign carry[N/M:1] = (!carry[N/M-1:0] & carry0) | (carry[N/M-1:0] & carry1);
assign c_out = carry[N/M];

logic[M-1:0] sum0[N/M-1:0];
logic[M-1:0] sum1[N/M-1:0];

generate
    genvar i;
    for(i = 0; i < N; i+=M) begin: gen_rca
        ripplecarry_adder #(.N(M)) rca0
        (
            .a(a[i+M-1:i]),
            .b(b[i+M-1:i]),
            .c_in(0),
            .sum(sum0[i/M]),
            .c_out(carry0[i/M])
        );
        ripplecarry_adder #(.N(M)) rca1
        (
            .a(a[i+M-1:i]),
            .b(b[i+M-1:i]),
            .c_in(1),
            .sum(sum1[i/M]),
            .c_out(carry1[i/M])
        );
        assign sum[i+M-1:i] = carry[i/M]? sum1[i/M] : sum0[i/M];
    end: gen_rca
endgenerate
endmodule