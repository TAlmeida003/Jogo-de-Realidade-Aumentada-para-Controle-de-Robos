# TCL File Generated by Component Editor 23.1
# Fri Sep 06 23:30:42 BRT 2024
# DO NOT MODIFY


# 
# io_avalon_interface "io_component" v1.0
#  2024.09.06.23:30:42
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module io_avalon_interface
# 
set_module_property DESCRIPTION ""
set_module_property NAME io_avalon_interface
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "My Own IP Cores."
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME io_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL io_avalon_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file controle.v VERILOG PATH controle.v
add_fileset_file edge_capture.v VERILOG PATH edge_capture.v
add_fileset_file edge_capture_clear.v VERILOG PATH edge_capture_clear.v
add_fileset_file edge_detector.v VERILOG PATH edge_detector.v
add_fileset_file i_o_data.v VERILOG PATH i_o_data.v
add_fileset_file io_avalon_interface.v VERILOG PATH io_avalon_interface.v TOP_LEVEL_FILE
add_fileset_file select_data.v VERILOG PATH select_data.v
add_fileset_file select_read_data.v VERILOG PATH output_files/select_read_data.v
add_fileset_file top_input_controller.v VERILOG PATH output_files/top_input_controller.v

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL io_avalon_interface
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file controle.v VERILOG PATH controle.v
add_fileset_file edge_capture.v VERILOG PATH edge_capture.v
add_fileset_file edge_capture_clear.v VERILOG PATH edge_capture_clear.v
add_fileset_file edge_detector.v VERILOG PATH edge_detector.v
add_fileset_file i_o_data.v VERILOG PATH i_o_data.v
add_fileset_file io_avalon_interface.v VERILOG PATH io_avalon_interface.v
add_fileset_file select_data.v VERILOG PATH select_data.v
add_fileset_file select_read_data.v VERILOG PATH output_files/select_read_data.v
add_fileset_file top_input_controller.v VERILOG PATH output_files/top_input_controller.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink rst_n reset_n Input 1


# 
# connection point avalon_slave_1
# 
add_interface avalon_slave_1 avalon end
set_interface_property avalon_slave_1 addressUnits WORDS
set_interface_property avalon_slave_1 associatedClock clock
set_interface_property avalon_slave_1 associatedReset reset_sink
set_interface_property avalon_slave_1 bitsPerSymbol 8
set_interface_property avalon_slave_1 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_1 burstcountUnits WORDS
set_interface_property avalon_slave_1 explicitAddressSpan 0
set_interface_property avalon_slave_1 holdTime 0
set_interface_property avalon_slave_1 linewrapBursts false
set_interface_property avalon_slave_1 maximumPendingReadTransactions 0
set_interface_property avalon_slave_1 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_1 readLatency 0
set_interface_property avalon_slave_1 readWaitTime 1
set_interface_property avalon_slave_1 setupTime 0
set_interface_property avalon_slave_1 timingUnits Cycles
set_interface_property avalon_slave_1 writeWaitTime 0
set_interface_property avalon_slave_1 ENABLED true
set_interface_property avalon_slave_1 EXPORT_OF ""
set_interface_property avalon_slave_1 PORT_NAME_MAP ""
set_interface_property avalon_slave_1 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_1 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_1 address address Input 1
add_interface_port avalon_slave_1 read read Input 1
add_interface_port avalon_slave_1 write write Input 1
add_interface_port avalon_slave_1 chipselect chipselect Input 1
add_interface_port avalon_slave_1 writedata writedata Input 32
add_interface_port avalon_slave_1 readdata readdata Output 32
add_interface_port avalon_slave_1 waitrequest waitrequest Output 1
set_interface_assignment avalon_slave_1 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_1 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point inputs_controle
# 
add_interface inputs_controle conduit end
set_interface_property inputs_controle associatedClock clock
set_interface_property inputs_controle associatedReset ""
set_interface_property inputs_controle ENABLED true
set_interface_property inputs_controle EXPORT_OF ""
set_interface_property inputs_controle PORT_NAME_MAP ""
set_interface_property inputs_controle CMSIS_SVD_VARIABLES ""
set_interface_property inputs_controle SVD_ADDRESS_GROUP ""

add_interface_port inputs_controle input_data writebyteenable_n Input 12
add_interface_port inputs_controle leds readdata Output 8
