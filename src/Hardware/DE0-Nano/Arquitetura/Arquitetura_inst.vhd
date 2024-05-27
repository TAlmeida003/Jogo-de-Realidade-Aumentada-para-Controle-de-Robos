	component Arquitetura is
		port (
			a_button_export           : in  std_logic                     := 'X';             -- export
			b_button_export           : in  std_logic                     := 'X';             -- export
			clk_clk                   : in  std_logic                     := 'X';             -- clk
			data_a_export             : out std_logic_vector(31 downto 0);                    -- export
			data_b_export             : out std_logic_vector(31 downto 0);                    -- export
			direction_analogic_export : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			reset_reset_n             : in  std_logic                     := 'X';             -- reset_n
			reset_pulsecounter_export : out std_logic;                                        -- export
			screen_export             : in  std_logic                     := 'X';             -- export
			select_button_export      : in  std_logic                     := 'X';             -- export
			start_button_export       : in  std_logic                     := 'X';             -- export
			tl_button_export          : in  std_logic                     := 'X';             -- export
			tr_button_export          : in  std_logic                     := 'X';             -- export
			wrfull_export             : in  std_logic                     := 'X';             -- export
			wrreg_export              : out std_logic;                                        -- export
			x_button_export           : in  std_logic                     := 'X';             -- export
			y_button_export           : in  std_logic                     := 'X'              -- export
		);
	end component Arquitetura;

	u0 : component Arquitetura
		port map (
			a_button_export           => CONNECTED_TO_a_button_export,           --           a_button.export
			b_button_export           => CONNECTED_TO_b_button_export,           --           b_button.export
			clk_clk                   => CONNECTED_TO_clk_clk,                   --                clk.clk
			data_a_export             => CONNECTED_TO_data_a_export,             --             data_a.export
			data_b_export             => CONNECTED_TO_data_b_export,             --             data_b.export
			direction_analogic_export => CONNECTED_TO_direction_analogic_export, -- direction_analogic.export
			reset_reset_n             => CONNECTED_TO_reset_reset_n,             --              reset.reset_n
			reset_pulsecounter_export => CONNECTED_TO_reset_pulsecounter_export, -- reset_pulsecounter.export
			screen_export             => CONNECTED_TO_screen_export,             --             screen.export
			select_button_export      => CONNECTED_TO_select_button_export,      --      select_button.export
			start_button_export       => CONNECTED_TO_start_button_export,       --       start_button.export
			tl_button_export          => CONNECTED_TO_tl_button_export,          --          tl_button.export
			tr_button_export          => CONNECTED_TO_tr_button_export,          --          tr_button.export
			wrfull_export             => CONNECTED_TO_wrfull_export,             --             wrfull.export
			wrreg_export              => CONNECTED_TO_wrreg_export,              --              wrreg.export
			x_button_export           => CONNECTED_TO_x_button_export,           --           x_button.export
			y_button_export           => CONNECTED_TO_y_button_export            --           y_button.export
		);

