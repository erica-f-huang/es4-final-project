module top(
        input  clock_in,
        output HSYNC,
        output VSYNC,
        output logic [5:0] rgb,
	output locked                   // leave floating
);


logic intermediate_clk;
logic [9:0] curr_col;
logic [9:0] curr_row;
logic valid;

        mypll u_mypll(
                .clock_in(clock_in),
                .clock_out(intermediate_clk),
                .locked(locked)
        );

        vga u_vga(
                .clk(intermediate_clk),
                .HSYNC(HSYNC),
                .VSYNC(VSYNC),
                .valid(valid),
                .curr_col(curr_col),
                .curr_row(curr_row)
        );

        pattern_gen u_pattern_gen(
                .col(curr_col),
                .row(curr_row),
                .valid(valid),
                .rgb(rgb)
        );





endmodule