module lookaheadcarry_unit#(parameter N=4)
(
    input logic[N-1:0] g, p,
    input c_in,
    output logic[N-1:0] c_out,
    output logic GG, PG
);

logic[N:0] gen;
assign gen = {g, c_in};

assign PG = &p;

//Propagation/generation options for the group generate
logic[N-1:0] prop_gens;
assign prop_gens[0] = g[N-1];

assign GG = |prop_gens;

generate
    genvar i;
    genvar j;
    for(i = 0; i < N; i++) begin: carries
        //Propagation/generation options for each carry out
        logic[i+1:0] prop_carry;
        assign prop_carry[0] = gen[i+1];
        for(j = 0; j < i+1; j++) begin: props
            assign prop_carry[j+1] = &p[i:j] & gen[j];
        end: props
        assign c_out[i] = |prop_carry;
    end: carries
    for(i = 0; i < N-1; i++) begin: group_gen
        assign prop_gens[i+1] = &p[N-1:i+1] & g[i];
    end: group_gen
endgenerate
endmodule