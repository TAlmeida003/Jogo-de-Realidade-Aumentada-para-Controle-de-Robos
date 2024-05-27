#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -name {main_clk} -period 20 [get_ports {main_clk}]
#create_clock -add -name sys_clk_div -period 80 -waveform {0 40} [get_nets {inst3|new_clock}]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks -create_base_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************
set_input_delay -clock main_clk -add_delay 0 [get_ports reset]
set_input_delay -clock main_clk -add_delay 0 [get_ports direction_analogic[0]]
set_input_delay -clock main_clk -add_delay 0 [get_ports direction_analogic[1]]
set_input_delay -clock main_clk -add_delay 0 [get_ports direction_analogic[2]]
set_input_delay -clock main_clk -add_delay 0 [get_ports direction_analogic[3]]
set_input_delay -clock main_clk -add_delay 0 [get_ports select_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports start_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports x_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports y_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports b_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports a_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports tr_button]
set_input_delay -clock main_clk -add_delay 0 [get_ports tl_button] 
#**************************************************************
# Set Output Delay
#**************************************************************


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from * -to [get_ports {*}]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



