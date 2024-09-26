	component IO_contoller is
		port (
			clk_clk                   : in  std_logic                     := 'X';             -- clk
			in_data_readdata          : out std_logic_vector(7 downto 0);                     -- readdata
			in_data_writebyteenable_n : in  std_logic_vector(11 downto 0) := (others => 'X'); -- writebyteenable_n
			reset_reset_n             : in  std_logic                     := 'X'              -- reset_n
		);
	end component IO_contoller;

	u0 : component IO_contoller
		port map (
			clk_clk                   => CONNECTED_TO_clk_clk,                   --     clk.clk
			in_data_readdata          => CONNECTED_TO_in_data_readdata,          -- in_data.readdata
			in_data_writebyteenable_n => CONNECTED_TO_in_data_writebyteenable_n, --        .writebyteenable_n
			reset_reset_n             => CONNECTED_TO_reset_reset_n              --   reset.reset_n
		);

