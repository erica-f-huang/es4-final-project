module pattern_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] rgb
);

logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;

int stripe_width = 35;
int stripe_gap = 20;

int green_begin = 220;
int green_end = green_begin + stripe_width;

int yellow_begin = green_end + stripe_gap;
int yellow_end = yellow_begin + stripe_width;

int blue_begin = yellow_end + stripe_gap;
int blue_end = blue_begin + stripe_width;

int orange_begin = blue_end + stripe_gap;
int orange_end = orange_begin + stripe_width;

int white_begin = orange_end + stripe_gap;
int white_end = white_begin + (3*stripe_width);


//look at ipad diagram -- split 20 rows into 5 sections to write numbers
int scaled_down_row_height = 5;

int sec_a_begin = 70;

int sec_b_begin = sec_a_begin + 2*scaled_down_row_height;

int sec_c_begin = sec_b_begin + scaled_down_row_height;

int sec_d_begin = sec_c_begin + 2*scaled_down_row_height;

int sec_e_begin = sec_d_begin + scaled_down_row_height;

int sec_e_end = sec_e_begin + 2*scaled_down_row_height;

always_comb begin
        if (valid == 1) begin
                // make left col white to get border
                if ((col == 1) | (col == 639)) begin
                        rgb = white;
                //get squares for score and "score"
                end else if ((20 < col) & (col < 150)) begin
                        //rectangle for "score"
                        if ((20 < row) & (row < 60)) begin
                                rgb = white;

                        //get individual number blocks (5 total)
                        //row section A
                        end else if ((sec_a_begin <= row) & (row < sec_b_begin)) begin
                                if ((20 < col) & (col < 45)) begin
                                        rgb = white;
                                end else if ((46 < col) & (col < 71 - 5))begin
                                        rgb = white;
                                end else if ((72 < col) & (col < 97))begin
                                        rgb = white;
                                end else if ((98 < col) & (col < 123))begin
                                        rgb = white;
                                end else if ((124 < col) & (col < 149))begin
                                        rgb = white;
                                end else begin
                                        rgb = black;
                                end
                        end else if ((sec_b_begin <= row) & (row < sec_c_begin)) begin
                                if ((20 < col) & (col < 45)) begin
                                        rgb = green;
                                end else if ((46 < col) & (col < 71))begin
                                        rgb = green;
                                end else if ((72 < col) & (col < 97))begin
                                        rgb = green;
                                end else if ((98 < col) & (col < 123))begin
                                        rgb = green;
                                end else if ((124 < col) & (col < 149))begin
                                        rgb = green;
                                end else begin
                                        rgb = black;
                                end
                        end else if ((sec_c_begin <= row) & (row < sec_d_begin)) begin
                                if ((20 < col) & (col < 45)) begin
                                        rgb = red;
                                end else if ((46 < col) & (col < 71))begin
                                        rgb = red;
                                end else if ((72 < col) & (col < 97))begin
                                        rgb = red;
                                end else if ((98 < col) & (col < 123))begin
                                        rgb = red;
                                end else if ((124 < col) & (col < 149))begin
                                        rgb = red;
                                end else begin
                                        rgb = black;
                                end
                        end else if ((sec_d_begin <= row) & (row < sec_e_begin)) begin
                                if ((20 < col) & (col < 45)) begin
                                        rgb = blue;
                                end else if ((46 < col) & (col < 71))begin
                                        rgb = blue;
                                end else if ((72 < col) & (col < 97))begin
                                        rgb = blue;
                                end else if ((98 < col) & (col < 123))begin
                                        rgb = blue;
                                end else if ((124 < col) & (col < 149))begin
                                        rgb = blue;
                                end else begin
                                        rgb = black;
                                end
                        end else if ((sec_e_begin <= row) & (row < sec_e_end)) begin
                                if ((20 < col) & (col < 45)) begin
                                        rgb = white;
                                end else if ((46 < col) & (col < 71))begin
                                        rgb = white;
                                end else if ((72 < col) & (col < 97))begin
                                        rgb = white;
                                end else if ((98 < col) & (col < 123))begin
                                        rgb = white;
                                end else if ((124 < col) & (col < 149))begin
                                        rgb = white;
                                end else begin
                                        rgb = black;
                                end
                        
                        
                        // end else if ((70 < row) & (row < 110)) begin
                        //         if ((20 < col) & (col < 45)) begin
                        //                 rgb = white;
                        //         end else if ((46 < col) & (col < 71))begin
                        //                 rgb = white;
                        //         end else if ((72 < col) & (col < 97))begin
                        //                 rgb = white;
                        //         end else if ((98 < col) & (col < 123))begin
                        //                 rgb = white;
                        //         end else if ((124 < col) & (col < 149))begin
                        //                 rgb = white;
                        //         end else begin
                        //                 rgb = black;
                        //         end
                        end else begin
                                rgb = black;
                        end

                //stripes
                end else if ((green_begin < col) & (col < green_end)) begin
                        rgb = green;
                end else if ((yellow_begin < col) & (col < yellow_end)) begin
                        rgb = yellow;
                end else if ((blue_begin < col) & (col < blue_end)) begin
                        rgb = blue;
                end else if ((orange_begin < col) & (col < orange_end)) begin
                        rgb = orange;
                end else if ((white_begin < col) & (col < white_end)) begin
                        rgb = white;
                
                //make rest black
                end else begin
                        rgb = black;
                end
        end else begin
                rgb = black;
        end
end


endmodule