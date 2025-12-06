module screen_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] rgb,
        input logic clk
);

//COLORS
logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;


//DIGIT INFO
logic[5:0] digit1;
logic[6:0] digit1_offset = 7'd20;

logic[5:0] digit2;
logic[6:0] digit2_offset = 7'd46;

logic[5:0] digit3;
logic[6:0] digit3_offset = 7'd72;

logic[5:0] digit4;
logic[6:0] digit4_offset = 7'd98;

logic[5:0] digit5;
logic[6:0] digit5_offset = 7'd124;


//SCORE
logic[16:0] score_val = 17'd30085;

//DIGIT GENERATORS
digit_gen digit1_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit1_offset),         //in
        .score(score_val),              //in
        .digit_rgb(digit1)              //out
);

digit_gen digit2_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit2_offset),         //in
        .score(score_val),              //in
        .digit_rgb(digit2)              //out
);

digit_gen digit3_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit3_offset),         //in
        .score(score_val),              //in
        .digit_rgb(digit3)              //out
);

digit_gen digit4_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit4_offset),         //in
        .score(score_val),              //in
        .digit_rgb(digit4)              //out
);

digit_gen digit5_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit5_offset),         //in
        .score(score_val),              //in
        .digit_rgb(digit5)              //out
);


//"SCORE" GENERATOR
logic[5:0] score_title;
score_title_gen score_title_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .score_rgb(score_title)         //out
);




//BLOCK LANE INFO
logic[6:0] stripe_width = 35;
logic[6:0] stripe_gap = 20;

//offsets
logic[9:0] green_begin = 220;
logic[9:0] yellow_begin = green_begin + stripe_width + stripe_gap; //275
logic[9:0] blue_begin = yellow_begin + stripe_width + stripe_gap; //330
logic[9:0] orange_begin = blue_begin + stripe_width + stripe_gap; //385
logic[9:0] white_begin = orange_begin + stripe_width + stripe_gap; //440

//feeds into rgb
logic[5:0] green_block;
logic[5:0] yellow_block;
logic[5:0] blue_block;
logic[5:0] orange_block;
logic[5:0] white_block;


//BLOCK GENERATORS

logic [20:0] green_note = 21'b111111100111111100000;
logic [20:0] yellow_note = 21'b001111111001111111000;
logic [20:0] blue_note = 21'b000000011111110000000;
logic [20:0] orange_note = 21'b111111100000011111110;
logic [20:0] white_note = 21'b111111101111111000000;
logic [5:0] which_note = 0;

always_ff @(posedge clk) begin
        if(which_note == 5'd21) begin
                which_note = 0;
        end else begin
                which_note <= which_note + 1;
        end
end

button_lane u_green_lane(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .clk(clk),
        .block_color(green),
        .drop_block(green_note[which_note%21]),
        .lane_rgb(green_block)
);

button_lane u_yellow_lane(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .clk(clk),
        .block_color(yellow),
        .drop_block(yellow_note[which_note%21]),
        .lane_rgb(yellow_block)
);

button_lane u_blue_lane(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .clk(clk),
        .block_color(blue),
        .drop_block(blue_note[which_note%21]),
        .lane_rgb(blue_block)
);

button_lane u_orange_lane(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .clk(clk),
        .block_color(orange),
        .drop_block(orange_note[which_note%21]),
        .lane_rgb(orange_block)
);

strum_lane u_white_lane(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .clk(clk),
        .drop_block(white_note[which_note%21]),
        .lane_rgb(white_block)
);

always_comb begin
        if (valid == 1) begin
                //L&&R EDGE BORDER
                if ((col == 1) | (col == 639)) begin
                        rgb = white;

                //HIT ZONE
                end else if ((425 < row && row <= 430) |
                        (465 < row && row <= 470)) begin
                                if(210 < col && col <= 555) begin
                                        rgb = 6'b101010;
                                end else begin
                                        rgb = black;
                                end
                //"SCORE" && SCORE VAL
                end else if ((20 < col) && (col < 150)) begin
                        //"SCORE"
                        if ((20 < row) && (row < 60)) begin
                                rgb = score_title;

                        //SCORE VALUE
                        end else if ((70 < row) && (row < 110)) begin
                                //10000
                                if ((20 < col) && (col <= 45)) begin
                                        rgb = digit1;
                                end else 
                                //01000
                                if ((46 < col) && (col <= 71))begin
                                        rgb = digit2;
                                end else 
                                //00100
                                if ((72 < col) && (col <= 97))begin
                                        rgb = digit3;
                                end else 
                                //00010
                                if ((98 < col) && (col <= 123))begin
                                        rgb = digit4;
                                end else 
                                //00001
                                if ((124 < col) && (col <= 149))begin
                                        rgb = digit5;
                                end else begin
                                        rgb = black;
                                end
                        end else begin
                                rgb = black;
                        end

                //BLOCK LANES
                end else if ((green_begin < col) && (col < (green_begin + stripe_width))) begin
                        rgb = green_block;
                end else if ((yellow_begin < col) && (col < (yellow_begin + stripe_width))) begin
                        rgb = yellow_block;
                end else if ((blue_begin < col) && (col < (blue_begin + stripe_width))) begin
                        rgb = blue_block;
                end else if ((orange_begin < col) && (col < (orange_begin + stripe_width))) begin
                        rgb = orange_block;
                end else if ((white_begin < col) && (col < (white_begin + 3*stripe_width))) begin
                        rgb = white_block;

                //REST OF SCREEN
                end else begin
                        rgb = black;
                end

        end else begin
                rgb = black;
        end
end







endmodule