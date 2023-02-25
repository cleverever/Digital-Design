//`include "accumulator"
module accumulator_multiplier#(parameter N=32)
(
    input logic clock, reset,
    input logic[N-1:0] multiplicand, multiplier,
    output logic[N*2-1:0] out,
    output logic done
);

logic[$clog2(N+1)-1:0] count;

logic[N*2-1:0] to_add;
assign to_add = multiplier[count]? multiplicand << count : 0;

accumulator #(.N(N)) accumulator
(
    .clock(clock),
    .reset(reset),
    .in(to_add),
    .out(out)
);

always_ff @(posedge clock, posedge reset) begin
    if(reset) begin
        count <= 0;
        done <= 0;
    end
    else if(count != N) begin
        count <= count + 1;
        done <= 0;
    end
    else begin
        count <= count;
        done <= 1;
    end
end
endmodule