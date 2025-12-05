module green_lane(
        input logic[9:0] col,
        input logic[9:0] row,
        input logic valid,
        input logic clk,
        output logic[5:0] lane_rgb,
        input logic button
);

logic [9:0] y = 35;

logic data_in = 1;


always_comb begin
        lane_rgb = 6'd0;  // default

        for (int i = 0; i < 96; i++) begin
                if (shift_reg[i] && (row >= i*5) && (row < i*5 + 5)) begin
                        lane_rgb = 6'b001100;
                end
        end
        // for (int i = 0; i < 96; i++) begin
        //         if (shift_reg[i] == 1) begin     // or != '0 if multi-bit
        //                 if(((i*5) <= row) & row < (i*5 + 5)) begin
        //                         lane_rgb = 6'b001100;
        //                 end else begin
        //                         lane_rgb = 6'd0;
        //                 end
        //         end else begin
        //                 lane_rgb = 6'd0;
        //         end
        // end
end



logic shift_reg [96]; //96 shift regs
logic [3:0] pulse_counter = 0;

always_ff @(posedge clk) begin
        //click button and it stays high for 7 cycles
        if ((button == 1'b0) || ((pulse_counter % 8) != 0)) begin   
                // set 1'b1 for a single-pulse block
                shift_reg[0] <= 1;
                pulse_counter <= pulse_counter + 1;
        end else begin
                pulse_counter <= 0;
                shift_reg[0] <= 0;
        end

        /*
        - CHECK THIS EVERY 7 CLOCK CYCLES SO IT PUTS 7 5PIXEL SEGMENTS AT ONCE TO CREATE A BLOCK
        - but then it will also be low for 7 cycles
        - nice to haveitis
        */
        
end

// Generate the remaining frames
genvar i;
generate
for (i = 1; i < 96; i++) begin : gen_shift
        always_ff @(posedge clk) begin
                shift_reg[i] <= shift_reg[i-1];
        end
end
endgenerate


endmodule