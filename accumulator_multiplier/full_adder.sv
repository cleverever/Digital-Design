module full_adder
(
    input logic a, b, c_in,
    output logic g, p, sum, c_out
);

assign g = a & b;
assign p = a ^ b;
assign sum = p ^ c_in;
assign c_out = g | (p & c_in);
endmodule