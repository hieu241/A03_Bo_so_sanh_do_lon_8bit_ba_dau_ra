`timescale 1ns / 1ps

module tb;
    reg  [7:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg        ena;
    reg        clk;
    reg        rst_n;

    tt_um_a03_comparator uut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        ena = 1; clk = 0; rst_n = 1;
        
        // TC-01: A = 0, B = 0 (Kỳ vọng: A == B, uo_out[1] = 1)
        ui_in = 8'd0; uio_in = 8'd0; #10;

        // TC-02: A = 255, B = 0 (Kỳ vọng: A > B, uo_out[0] = 1)
        ui_in = 8'd255; uio_in = 8'd0; #10;

        // TC-03: A = 0, B = 255 (Kỳ vọng: A < B, uo_out[2] = 1)
        ui_in = 8'd0; uio_in = 8'd255; #10;

        // TC-04: A = 128, B = 127 (Kỳ vọng: A > B)
        ui_in = 8'd128; uio_in = 8'd127; #10;

        $display("PASS");
        $finish;
    end
endmodule
