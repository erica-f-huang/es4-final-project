module green_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic clk,
        output logic[5:0] lane_rgb
);

logic[6:0] stripe_width = 35;
logic[9:0] green_begin = 220;


always_comb begin
        if (valid == 1) begin
                if ((green_begin < col) & (col < (green_begin + stripe_width))) begin
                        lane_rgb = 6'b001100;
                end else begin
                        lane_rgb = 6'b000000;
                end
        end else begin
                lane_rgb = 6'b000000;
        end
end



endmodule