module full_adder
(
    input logic a, b, c_in,
    output logic sum, c_out
);

logic a_and_b;
assign a_and_b = a & b;

logic a_xor_b;
assign a_xor_b = a ^ b;

assign sum = a_xor_b ^ c_in;
assign c_out = a_and_b | (a_xor_b & c_in);
endmodule