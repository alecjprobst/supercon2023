
// Top level module for a VGA based flappy bird game to be included in Tiny Tapeout 05
//
// Author: Daniel Robinson (cutout on Discord)

module tt_um_wokwi_380409393770716161 (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock (25MHz)
    input  wire       rst_n     // reset_n - low to reset
);
	wire [9:0] h_count, v_count;
	wire [8:0] pixel_pos;
	wire red, green, blue;
	wire h_sync, v_sync;
	wire bright;

	assign uio_oe = 8'b11111111;
	assign uio_out = 8'b11111111;
	
	// Tiny VGA PMOD compatible outputs
	assign uo_out[0] = red;    // R1
	assign uo_out[1] = green;  // G1
	assign uo_out[2] = blue;   // B1
	assign uo_out[3] = v_sync; // vsync
	assign uo_out[4] = red;    // R0
	assign uo_out[5] = green;  // G0
	assign uo_out[6] = blue;   // B0
	assign uo_out[7] = h_sync; // hsync
	
	gameControl game (clk, rst_n, v_sync, pixel_pos);
	
	vgaControl controller (clk, rst_n, h_sync, v_sync, bright, h_count, v_count);
	
	bitGen bitGenerator (clk, rst_n, bright, h_count, v_count, pixel_pos, red, green, blue);
	
endmodule
