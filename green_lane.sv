module green_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic clk,
        output logic[5:0] lane_rgb
);

logic [4:0] signal = 5'b10000;

logic [5:0] count;
logic [9:0] y = 35;


always_comb begin
        if (signal[4] == 1) begin
                if((y - 35) < row & row <= y) begin
                        lane_rgb = 6'b001100;
                end else begin
                        lane_rgb = 6'd0;
                end
        end else begin
                lane_rgb = 6'b000000;
        end
end

// logic [88:0] lanes;

always_ff @(posedge clk) begin
        // genvar i;
        // generate
        //         for (i = 0; i < 89; i++) begin : //89 chunks of 5 bits
        //                 if(i == 0) begin
        //                         assign lanes[i] <= signal[4]
        //                         assign lanes[i + 1] <= signal[4]
        //                         assign anes[i + 2] <= signal[4]
        //                         assign lanes[i + 3] <= signal[4]
        //                         assign lanes[i + 4] <= signal[4]
        //                         assign lanes[i + 5] <= signal[4]
        //                         assign lanes[i + 6] <= signal[4]
        //                 end else begin
        //                         lanes[i] 
        //                 assign data_out[i] = ~data_in[i];
        //         end
        // endgenerate
        
        
        
        if(y >= 500) begin
                //generate block at top
                signal[4] <= 1'b0;
        end else begin
                y <= y + 5;
        end


end



endmodule