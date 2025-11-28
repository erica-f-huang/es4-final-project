module digit1_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic[6:0] offset,
        input logic[16:0] score,
        output logic[5:0] digit_rgb
);

logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;

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

logic sectionA = (70 < row) & (row <= 80);
logic sectionB = (80 < row) & (row <= 85);
logic sectionC = (85 < row) & (row <= 95);
logic sectionD = (95 < row) & (row <= 100);
logic sectionE = (100 < row) & (row <= 110);

logic[3:0] value;

always_comb begin
        //extract the specific digit
        case (offset)
                7'd20:  value = (score / 10000) % 10;   //digit1
                7'd46:  value = (score / 1000) % 10;    //digit2
                7'd72:  value = (score / 100) % 10;     //digit3
                7'd98:  value = (score / 10) % 10;      //digit4
                7'd124: value = (score / 1) % 10;       //digit5
                default: value = 4'd0;
        endcase

        if (valid == 1) begin
                if (value == 0) begin                                   //0
                        if (sectionA | sectionE) begin
                                digit_rgb = green;
                        end else
                        if (sectionB | sectionC | sectionD) begin
                                if(((offset < col) & (col <= (offset + 10))) | 
                        (((offset + 15) < col) & (col <= (offset + 25)))) begin
                                        digit_rgb = green;
                                end else begin
                                        digit_rgb = black;
                                end
                        end else begin
                                digit_rgb = black;    
                        end  
                end 
                else if (value == 1) begin                              //1
                        if (sectionA) begin
                                if(col <= (offset + 20)) begin
                                        digit_rgb = green;
                                end else begin
                                        digit_rgb = black;
                                end
                        end
                        else if (sectionB | sectionC | sectionD) begin
                                if (((offset + 5) < col) & (col < (offset + 20))) begin
                                        digit_rgb = green;
                                end else begin
                                        digit_rgb = black;
                                end
                        end
                        else if (sectionE) begin
                                digit_rgb = green;
                        end else begin
                                digit_rgb = black;
                        end
                end else begin
                        digit_rgb = yellow;
                end
        end else begin
                digit_rgb = black;
        end

end



endmodule