//`include "full_adder.sv"
module ripplecarry_adder#(parameter N=8)
(
    input logic[N-1:0] a, b,
    input logic c_in,
    output logic[N-1:0] sum,
    output logic c_out
);

logic carry[N:0];
assign carry[0] = c_in;
assign c_out = carry[N];

genvar i;
generate
    for(i = 0; i < N; i++) begin: gen_adder
        full_adder full_adder
        (
            .a(a[i]),
            .b(b[i]),
            .c_in(carry[i]),
            .sum(sum[i]),
            .c_out(carry[i+1])
        );
    end: gen_adder
endgenerate
endmodule