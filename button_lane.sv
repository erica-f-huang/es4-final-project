module button_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic clk,
        input logic [5:0] block_color,
        input logic drop_block,
        output logic[5:0] lane_rgb
);

logic [9:0] y = 35;

logic data_in = 1;


always_comb begin
        lane_rgb = 6'd0;  // default

        for (int i = 0; i < 96; i++) begin
                if (shift_reg[i] && (row >= i*5) && (row < i*5 + 5)) begin
                        lane_rgb = block_color;
                end
        end
end

logic shift_reg [96]; //96 shift regs

always_ff @(posedge clk) begin
        if(drop_block == 1) begin
                shift_reg[0] <= 1;
        end else begin
                shift_reg[0] <= 0;
        end
end

// Generate the shift registers for the frames
genvar i;
generate
for (i = 1; i < 96; i++) begin : gen_shift
        always_ff @(posedge clk) begin
                shift_reg[i] <= shift_reg[i-1];
        end
end
endgenerate


endmodule