module gameControl (
	input wire clock, reset, v_sync,
	output reg [8:0] pixel_pos
);
	reg game_over;
	reg restart_game;
	
	reg has_updated_during_current_v_sync;
	reg update_pulse;
	
	always @(posedge clock)
	begin
		if(!reset || v_sync)
		begin
			has_updated_during_current_v_sync <= 1'b0;
			update_pulse <= 1'b0;
		end
		else if (has_updated_during_current_v_sync == 1'b0)
		begin
			has_updated_during_current_v_sync <= 1'b1;
			update_pulse <= 1'b1;
		end
		else
		begin
			has_updated_during_current_v_sync <= 1'b1;
			update_pulse <= 1'b0;
		end
	end
	
	always @(posedge clock)
	begin
		if(!reset || restart_game)
		begin
			pixel_pos <= 9'd265;
			game_over <= 1'b0;
			restart_game <= 1'b0;
		end
		else if(update_pulse) begin
			if(!game_over)
			begin
				pixel_pos <= 9'd300;
			end
		end
	end
endmodule
