`default_nettype none

module tt_um_a03_comparator (
    input  wire [7:0] ui_in,    // 8 bit A [7:0]
    output wire [7:0] uo_out,   // uo_out[0]: A>B, uo_out[1]: A==B, uo_out[2]: A<B
    input  wire [7:0] uio_in,   // 8 bit B [7:0]
    output wire [7:0] uio_out,  // Khong su dung -> dat 0
    output wire [7:0] uio_oe,   // Tat ca chan uio la input -> uio_oe = 8'b0
    input  wire       ena,      // Luon = 1 khi duoc chon
    input  wire       clk,      // Xung nhip (Mach to hop, khong dung)
    input  wire       rst_n     // Reset tich cuc muc thap (Mach to hop, khong dung)
);

    // Dan nhan tin hieu theo de bai A03
    wire [7:0] a = ui_in;
    wire [7:0] b = uio_in;

    wire a_gt_b = (a > b);
    wire a_eq_b = (a == b);
    wire a_lt_b = (a < b);

    // Anh xa dau ra sang uo_out
    assign uo_out[0] = a_gt_b;
    assign uo_out[1] = a_eq_b;
    assign uo_out[2] = a_lt_b;
    assign uo_out[7:3] = 5'b00000; // Cac chan khong dung dat muc 0

    // Dat cac chan bidirectional lam dau vao thuan tuy
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Tranh warning unused input
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
