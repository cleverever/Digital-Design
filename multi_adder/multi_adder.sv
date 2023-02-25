//`include "carrylookahead_adder.sv"
//`include "carrysave_adder.sv"
module multi_adder#(parameter N=8, NUM_OPS=6)
(
    input logic[N-1:0] in[NUM_OPS-1:0],
    output logic[N-1+$clog2(NUM_OPS):0] sum
);

function automatic int levels(int initial_operands);
    int result = 1;
    for(int i = initial_operands; i > 2; i = (i / 3) * 2 + i % 3) begin
        result++;
    end
    return result;
endfunction

function automatic int operands(int current_level);
    int result = NUM_OPS;
    for(int i = 0; i < current_level; i++) begin
        result = (result / 3) * 2 + result % 3;
    end
    return result;
endfunction

function automatic int cla_levels(int size, int operands);
    int result = 1;
    for(int i = 4; i < size+$clog2(operands); i*=4) begin
        result++;
    end
    return result;
endfunction

localparam L = levels(NUM_OPS);
localparam CLA_LEVELS = cla_levels(N, NUM_OPS);

//Intermediate sum outputs from carry save adders
logic[N+$clog2(NUM_OPS):0] temp_sum[L:0][NUM_OPS-1:0]; //**For ModelSim simulation** = {default:'0};
assign temp_sum[0] = in;

logic[4**CLA_LEVELS:0] cla_sum;
assign sum = cla_sum[N-1+$clog2(NUM_OPS):0];

//Adder to generate the final sum
carrylookahead_adder #(.N(4), .LEVELS(CLA_LEVELS)) cla
(
    .a(temp_sum[L][0]),
    .b(temp_sum[L][1]),
    .c_in(0),
    .sum(cla_sum[4**CLA_LEVELS-1:0]),
    .c_out(cla_sum[4**CLA_LEVELS])
);

generate
    genvar i;
    genvar j;
    for(i = 0; i < L; i++) begin: gen_levels
        for(j = 0; j < operands(i); j++) begin: gen_sums
            //Add every 3 operands in a carry save adder
            if(j < operands(i) - (operands(i) % 3)) begin
                if(j % 3 == 0) begin
                    carrysave_adder #(.N(N+i)) csa
                    (
                        .a(temp_sum[i][j]),
                        .b(temp_sum[i][j+1]),
                        .c(temp_sum[i][j+2]),
                        .sum(temp_sum[i+1][(j/3)*2]),
                        .carry(temp_sum[i+1][(j/3)*2+1][N+i:1])
                    );
                    assign temp_sum[i+1][(j/3)*2+1][0] = 1'b0;
                end
            end
            //Pass unused operands to the next csa level
            else begin
                assign temp_sum[i+1][(j/3)*2+j%3] = temp_sum[i][j];
            end
        end: gen_sums
    end: gen_levels
endgenerate
endmodule