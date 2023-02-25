module half_adder
(
    input logic a, b,
    output logic sum, c_out
);

assign sum = a ^ b;
assign c_out = a & b;
endmodule