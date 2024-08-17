	component button is
		port (
			buttons_write : in std_logic_vector(7 downto 0) := (others => 'X'); -- write
			clk_clk       : in std_logic                    := 'X';             -- clk
			reset_reset_n : in std_logic                    := 'X'              -- reset_n
		);
	end component button;

	u0 : component button
		port map (
			buttons_write => CONNECTED_TO_buttons_write, -- buttons.write
			clk_clk       => CONNECTED_TO_clk_clk,       --     clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n  --   reset.reset_n
		);

