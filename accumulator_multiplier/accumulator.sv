//`include "carrysave_adder"
//`include "carrylookahead_adder"
module accumulator#(parameter N=16)
(
    input logic clock, reset,
    input logic[N-1:0] in,
    output logic[N-1:0] out
);

logic cla_carry[N:0];
assign cla_carry[0] = 0;

logic[N-1:0] u, v;
logic[N-1:0] u_reg;
logic[N:0] v_reg;

carrysave_adder #(.N(N)) csa
(
    .a(in),
    .b(u_reg),
    .c(v_reg[N-1:0]),
    .sum(u),
    .carry(v)
);

carrylookahead_adder #(.N(4), .LEVELS($clog2(N)/2 + $clog2(N)%2)) cla
(
    .a(u_reg),
    .b(v_reg),
    .c_in(0),
    .sum(out),
    .c_out()
);

always_ff @(posedge clock, posedge reset) begin
    if(reset) begin
        u_reg <= 0;
        v_reg <= 0;
    end
    else begin
        u_reg <= u;
        v_reg <= {v, 1'b0};
    end
end
endmodule