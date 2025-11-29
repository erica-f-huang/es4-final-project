module block_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic[9:0] offset,
        input logic[6:0] stripe_width,
        input logic[5:0] color,
        output logic[5:0] block_rgb
);

always_comb begin
        if (valid == 1) begin
                if ((offset < col) & (col < (offset + stripe_width))) begin
                        block_rgb = color;
                end else begin
                        block_rgb = 6'b000000;
                end
        end else begin
                block_rgb = 6'b000000;
        end
end




endmodule