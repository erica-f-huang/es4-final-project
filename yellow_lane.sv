module yellow_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] lane_rgb
);

logic[6:0] stripe_width = 35;
logic[9:0] yellow_begin = 275;


always_comb begin
        if (valid == 1) begin
                if ((yellow_begin < col) & (col < (yellow_begin + stripe_width))) begin
                        lane_rgb = 6'b111100;
                end else begin
                        lane_rgb = 6'b000000;
                end
        end else begin
                lane_rgb = 6'b000000;
        end
end



endmodule