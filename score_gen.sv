module score_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] rgb
);

//COLORS
logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;


//DIGIT LOCATIONS
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

logic[16:0] score = 17'd67890;


digit_gen digit1_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit1_offset),         //in
        .score(score),                  //in
        .digit_rgb(digit1)              //out
);

digit_gen digit2_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit2_offset),         //in
        .score(score),                  //in
        .digit_rgb(digit2)              //out
);

digit_gen digit3_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit3_offset),         //in
        .score(score),                  //in
        .digit_rgb(digit3)              //out
);

digit_gen digit4_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit4_offset),         //in
        .score(score),                  //in
        .digit_rgb(digit4)              //out
);

digit_gen digit5_gen(
        .col(col),                      //in
        .row(row),                      //in
        .valid(valid),                  //in
        .offset(digit5_offset),         //in
        .score(score),                  //in
        .digit_rgb(digit5)              //out
);

always_comb begin
        if (valid == 1) begin
                //make borders white
                if ((col == 1) | (col == 639)) begin
                        rgb = white;
                //get squares for score and "score"
                end else if ((20 < col) & (col < 150)) begin
                        if ((70 < row) & (row < 110)) begin
                                //10000
                                if ((20 < col) & (col <= 45)) begin
                                        rgb = digit1;
                                end else 
                                //01000
                                if ((46 < col) & (col <= 71))begin
                                        rgb = digit2;
                                end else 
                                //00100
                                if ((72 < col) & (col <= 97))begin
                                        rgb = digit3;
                                end else 
                                //00010
                                if ((98 < col) & (col <= 123))begin
                                        rgb = digit4;
                                end else 
                                //00001
                                if ((124 < col) & (col <= 149))begin
                                        rgb = digit5;
                                end else begin
                                        rgb = black;
                                end
                        end else begin
                                rgb = black;
                        end
                
                //make rest black
                end else begin
                        rgb = black;
                end

        end else begin
                rgb = black;
        end
end







endmodule