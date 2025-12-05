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
end

logic shift_reg [96]; //96 shift regs
logic [3:0] pulse_counter = 0;
logic [20:0] note = 21'b111111100111111100000;
logic [5:0] which_note = 0;

/* NOTE
instead of having a pulse counter just hardcode the 5bit signals to be hig for 7 cycles and to have at leats 1 cycle in between highs
*/

always_ff @(posedge clk) begin
        if(note[which_note%21] == 1) begin
                shift_reg[0] <= 1;
        end else begin
                shift_reg[0] <= 0;
        end

        if(which_note == 5'd21) begin
                which_note = 0;
        end else begin
                which_note <= which_note + 1;
        end

        
        // if((pulse_counter % 8) != 0) begin
        //         if (button == 1'b0) begin   // set 1'b1 for a single-pulse block
        //                 shift_reg[0] <= 1;
        //         end else begin
        //                 shift_reg[0] <= 0;
        //         end
        // end else begin
        //         shift_reg[0] <= 0;
        // end
        
end

// Generate the shift registers for the frames
genvar i;
generate
for (i = 1; i < 96; i++) begin : gen_shift
        always_ff @(posedge clk) begin
                shift_reg[i] <= shift_reg[i-1];
        end
end
endgenerate


endmodule