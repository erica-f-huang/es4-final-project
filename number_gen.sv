module number_gen(
        input logic [9:0] col,
        input logic[9:0] row,
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
logic[4:0] section_num_rows = 5;

logic[9:0] sec_a_begin = 70;
logic[9:0] sec_b_begin = sec_a_begin + 2*section_num_rows;
logic[9:0] sec_c_begin = sec_b_begin + section_num_rows;
logic[9:0] sec_d_begin = sec_c_begin + 2*section_num_rows;
logic[9:0] sec_e_begin = sec_d_begin + section_num_rows;
logic[9:0] sec_e_end = sec_e_begin + 2*section_num_rows;

logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;

logic a = 0;

always_comb begin
        if ((20 < col) & (col <=45)) begin
                //AE
                if (((sec_a_begin <= row) & (row < sec_b_begin)) || ((sec_e_begin <= row) & (row < sec_e_end))) begin
                        rgb = white;
                
                //BCD
                end else if ((sec_b_begin <= row) & (row < sec_e_begin)) begin
                        //get left and right parts of digit cols
                        if (((20 < col) & (col <= 30)) || ((25 < col) & (col <= 45))) begin
                                rgb = white;
                        end
                end else begin
                        rgb = black;
                end
        end
end






























// //DEPENDS ON INPUT "digit"
// logic[9:0] col_begin;
// logic[4:0] digit_width = 25;

// always_comb begin
//         //get which digit we are editing
//         case(digit)
//                 1: begin
//                         col_begin = 20;
//                 end
//                 2: begin
//                         col_begin = 46;
//                 end
//                 3: begin
//                         col_begin = 72;
//                 end
//                 4: begin
//                         col_begin = 98;
//                 end
//                 5: begin
//                         col_begin = 124;
//                 end
//         endcase

//         //draw number based on num input only when its ur digit
//         if(col_begin < col & col < col_begin + digit_width) begin
//                 case(num)
//                         0: begin
//                                 //AE
//                                 if ((sec_a_begin <= row) & (row < sec_b_begin) ||
//                                         (sec_e_begin <= row) & (row < sec_e_end)) begin
//                                         rgb = white;
//                                 //BCD
//                                 end else if ((sec_b_begin <= row) & (row < sec_e_begin)) begin
//                                         if      ((col_begin < col) & (col < col_begin + 9) || 
//                                                 (col_begin + 15 < col) & (col < (col_begin + digit_width))) begin
//                                                 rgb = white;
//                                         end else begin
//                                                 rgb = black;
//                                         end
                                
//                                 end else begin
//                                         rgb = black;
//                                 end
//                         end

//                 endcase
//         end
// end




endmodule