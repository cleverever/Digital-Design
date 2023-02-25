module associative_block#(parameter BITS_DATA = 32, BITS_ADDRESS = 32, ASSOCIATIVITY = 2)
(
    input logic clock, set, reset,
    input logic[BITS_ADDRESS-1:0] address,
    output logic[BITS_DATA-1:0]
);

logic[BITS_DATA-1:0] data[ASSOCIATIVITY-1:0];
logic valid[ASSOCIATIVITY-1:0];
logic recency[ASSOCIATIVITY-1:0];

always_ff @(posedge clock) begin
    if(set) begin
        
    end
end

endmodule