module score_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] rgb
);

//row : section_row == col : scaled_down_col == 5:1 ALWAYS  

/* ROWS UP NUMBER MAPPED TO SECTION (using the number 2 as an exmaple)
a        00000
a        00000
b           00
c        00000
c        00000
d        00      
e        00000
e        00000
*/

//KNOWN VALUES
// logic[4:0] section_num_rows = 5;

// logic[9:0] sec_a_begin = 70;
// logic[9:0] sec_b_begin = sec_a_begin + 2*section_num_rows;
// logic[9:0] sec_c_begin = sec_b_begin + section_num_rows;
// logic[9:0] sec_d_begin = sec_c_begin + 2*section_num_rows;
// logic[9:0] sec_e_begin = sec_d_begin + section_num_rows;
// logic[9:0] sec_e_end = sec_e_begin + 2*section_num_rows;

logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;


// logic[4:0] which_dig = 5'b00000;

logic[5:0] digit1;
logic[5:0] digit2 = white;
logic[5:0] digit3 = white;
logic[5:0] digit4 = white;
logic[5:0] digit5 = white;


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


        

        /*MAKES digit1 0*/

        if ((70 < row) & (row <= 80) |
                (100 < row) & (row <= 110)) begin
                digit1 = white;
        end else
        if ((80 < row) & (row <= 100)) begin
                if(((20 < col) & (col <= 30)) | 
                        ((35 < col) & (col <= 45))) begin
                        digit1 = white;
                end else begin
                        digit1 = black;
                end
        end else begin
                digit1 = black;    
        end  

        /* MAKES digit1 0 */
end







endmodule