module top(
        input  clock_in,                
        output HSYNC,                   //go to vga adapter
        output VSYNC,                   //go to vga adapter
        output logic [5:0] rgb,         //go to vga adapter
	output locked,                   // leave floating
        input logic button
);


logic intermediate_clk;
logic [9:0] curr_col;
logic [9:0] curr_row;
logic valid;

        mypll u_mypll(
                .clock_in(clock_in),            //in
                .clock_out(intermediate_clk),   //out
                .locked(locked)                 //out
        );

        vga u_vga(
                .clk(intermediate_clk),         //in
                .HSYNC(HSYNC),                  //out
                .VSYNC(VSYNC),                  //out
                .valid(valid),                  //out
                .curr_col(curr_col),            //out
                .curr_row(curr_row)             //out
        );

logic counter_clk;
        counter u_counter(
                .in_clk(intermediate_clk),
                .out_clk(counter_clk)
        );

        screen_gen u_screen_gen(
                .col(curr_col),                 //in
                .row(curr_row),                 //in
                .valid(valid),                  //in
                .rgb(rgb),                      //out
                .clk(counter_clk),
                .button(button)
        );





endmodule