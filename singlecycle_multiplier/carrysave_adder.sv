//`include "full_adder.sv"
module carrysave_adder#(parameter N=8)
(
    input logic[N-1:0] a, b, c,
    output logic[N-1:0] sum, carry
);

generate
    genvar i;
    for(i = 0; i < N; i++) begin: gen_adders
        full_adder full_adder
        (
            .a(a[i]),
            .b(b[i]),
            .c_in(c[i]),
            .sum(sum[i]),
            .c_out(carry[i])
        );
    end: gen_adders
endgenerate
endmodule