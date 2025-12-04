module green_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic clk,
        output logic[5:0] lane_rgb
);

logic [9:0] y = 35;
logic fall = 1;

// logic [6:0] clk_counter = 0;
// logic [6:0] count;



always_comb begin
        // if((y - 35) < row & row <= y) begin
        //                 lane_rgb = 6'b001100;
        //         end else begin
        //                 lane_rgb = 6'd0;
        //         end
        if (fall == 1) begin
                if((y - 35) < row & row <= y) begin
                        lane_rgb = 6'b001100;
                end else begin
                        lane_rgb = 6'd0;
                end
        end else begin
                lane_rgb = 6'b000000;
        end
end

always_ff @(posedge clk) begin
        if(y >= 500) begin
                //generate block at top
                fall <= 1'b1;
                y <= 35;
        end else begin
                y <= y + 5;
        end

        // if(clk_counter == 8'hFF) begin   //HOX >= 8 or else HOB wont be 1
        //         clk_counter <= 0;             //reset to 0 if max val
        //         fall <= 1'b1;
        //         y <= 35;
        // end else begin
        //         clk_counter <= clk_counter + 1;     //increment by 1
        // end

        // if(count == 7'b1000000) begin //but this counter is not a multiple of the frames so at some point it will get set low in the middle of the screen
        //         fall <= 1'b1;
        //         y <= 35;
        // end

end



endmodule