//`include "full_adder.sv"
//`include "lookaheadcarry_unit"
module carrylookahead_adder#(parameter N=4, LEVELS=2)
(
    input logic[N**LEVELS-1:0] a, b,
    input logic c_in,
    output logic[N**LEVELS-1:0] sum,
    output logic c_out
);

localparam size = N**LEVELS;

//Nets connecting the different levels of lookahead carry units
logic[size-1:0] g[LEVELS:0];
logic[size-1:0] p[LEVELS:0];
logic[size:0] carry[LEVELS:0];
assign c_out = carry[LEVELS-1][N];

generate
    genvar i;
    genvar j;

    //Generate full adders for the top level
    for(i = 0; i < size; i++) begin: adders
        full_adder fa
        (
            .a(a[i]),
            .b(b[i]),
            .c_in(carry[0][i]),
            .g(g[0][i]),
            .p(p[0][i]),
            .sum(sum[i]),
            .c_out()
        );
    end: adders
    for(i = 0; i < LEVELS+1; i++) begin: carry_in
        assign carry[i][0] = c_in;
    end: carry_in

    //Generate lookahead carry units on lower levels to calculate the carries
    for(i = 1; i < LEVELS+1; i++) begin: level
        for(j = 0; j < size / (N**i); j++) begin: lookahead
            lookaheadcarry_unit #(.N(N)) lcu
            (
                .g(g[i-1][j*(N**i)+N-1:j*(N**i)]),
                .p(p[i-1][j*(N**i)+N-1:j*(N**i)]),
                .c_in(carry[i][j]),
                .c_out(carry[i-1][j*(N**i)+N:j*(N**i)+1]),
                .GG(g[i][j]),
                .PG(p[i][j])
            );
        end: lookahead
    end: level
endgenerate
endmodule