	component Arquitetura is
		port (
			clk_clk                   : in  std_logic                     := 'X';             -- clk
			data_a_export             : out std_logic_vector(31 downto 0);                    -- export
			data_b_export             : out std_logic_vector(31 downto 0);                    -- export
			irq_joystick_export       : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			rd_joystick_lsb_export    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			rd_joystick_msb_export    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			reset_reset_n             : in  std_logic                     := 'X';             -- reset_n
			reset_pulsecounter_export : out std_logic;                                        -- export
			screen_export             : in  std_logic                     := 'X';             -- export
			we_joystick_export        : out std_logic;                                        -- export
			we_joystick_lsb_export    : out std_logic_vector(31 downto 0);                    -- export
			we_joystick_msb_export    : out std_logic_vector(31 downto 0);                    -- export
			wrfull_export             : in  std_logic                     := 'X';             -- export
			wrreg_export              : out std_logic                                         -- export
		);
	end component Arquitetura;

	u0 : component Arquitetura
		port map (
			clk_clk                   => CONNECTED_TO_clk_clk,                   --                clk.clk
			data_a_export             => CONNECTED_TO_data_a_export,             --             data_a.export
			data_b_export             => CONNECTED_TO_data_b_export,             --             data_b.export
			irq_joystick_export       => CONNECTED_TO_irq_joystick_export,       --       irq_joystick.export
			rd_joystick_lsb_export    => CONNECTED_TO_rd_joystick_lsb_export,    --    rd_joystick_lsb.export
			rd_joystick_msb_export    => CONNECTED_TO_rd_joystick_msb_export,    --    rd_joystick_msb.export
			reset_reset_n             => CONNECTED_TO_reset_reset_n,             --              reset.reset_n
			reset_pulsecounter_export => CONNECTED_TO_reset_pulsecounter_export, -- reset_pulsecounter.export
			screen_export             => CONNECTED_TO_screen_export,             --             screen.export
			we_joystick_export        => CONNECTED_TO_we_joystick_export,        --        we_joystick.export
			we_joystick_lsb_export    => CONNECTED_TO_we_joystick_lsb_export,    --    we_joystick_lsb.export
			we_joystick_msb_export    => CONNECTED_TO_we_joystick_msb_export,    --    we_joystick_msb.export
			wrfull_export             => CONNECTED_TO_wrfull_export,             --             wrfull.export
			wrreg_export              => CONNECTED_TO_wrreg_export               --              wrreg.export
		);

