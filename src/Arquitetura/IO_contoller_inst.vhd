	component IO_contoller is
		port (
			clk_clk            : in  std_logic                     := 'X';             -- clk
			irq_export         : in  std_logic                     := 'X';             -- export
			rd_data_lsb_export : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			rd_data_msb_export : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			reset_reset_n      : in  std_logic                     := 'X';             -- reset_n
			we_export          : out std_logic;                                        -- export
			we_data_lsb_export : out std_logic_vector(31 downto 0);                    -- export
			we_data_msb_export : out std_logic_vector(31 downto 0)                     -- export
		);
	end component IO_contoller;

	u0 : component IO_contoller
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			irq_export         => CONNECTED_TO_irq_export,         --         irq.export
			rd_data_lsb_export => CONNECTED_TO_rd_data_lsb_export, -- rd_data_lsb.export
			rd_data_msb_export => CONNECTED_TO_rd_data_msb_export, -- rd_data_msb.export
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --       reset.reset_n
			we_export          => CONNECTED_TO_we_export,          --          we.export
			we_data_lsb_export => CONNECTED_TO_we_data_lsb_export, -- we_data_lsb.export
			we_data_msb_export => CONNECTED_TO_we_data_msb_export  -- we_data_msb.export
		);

