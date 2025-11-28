module digit2_gen(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        output logic[5:0] digit
);

logic[5:0] red = 6'b110000;
logic[5:0] green = 6'b001100;
logic[5:0] blue = 6'b000011;
logic[5:0] yellow = 6'b111100;
logic[5:0] orange = 6'b110100;
logic[5:0] white = 6'b111111;
logic[5:0] black = 6'd0;

always_comb begin
        if (valid == 1) begin
                /*MAKES digit 0*/

                if ((70 < row) & (row <= 80) |
                   (100 < row) & (row <= 110)) begin
                        digit = green;
                end else
                if ((80 < row) & (row <= 100)) begin
                        if(((46 < col) & (col <= 56)) | 
                           ((61 < col) & (col <= 71))) begin
                                digit = green;
                        end else begin
                                digit = black;
                        end
                end else begin
                        digit = black;    
                end  

                 /* MAKES digit 0 */
        end else begin
                digit = black;
        end

end



endmodule