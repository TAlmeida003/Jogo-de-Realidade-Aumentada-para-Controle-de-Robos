# TCL File Generated by Component Editor 23.1
# Fri Jan 24 00:30:52 BRT 2025
# DO NOT MODIFY


# 
# uart_interface "uart_component" v1.0
#  2025.01.24.00:30:52
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module uart_interface
# 
set_module_property DESCRIPTION ""
set_module_property NAME uart_interface
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME uart_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL uart_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file baud_rate_gen.v VERILOG PATH modulos/UART/baud_rate_gen.v
add_fileset_file fifo_cir.v VERILOG PATH modulos/UART/fifo_cir.v
add_fileset_file interrupt_control.v VERILOG PATH modulos/UART/interrupt_control.v
add_fileset_file modem_control.v VERILOG PATH modulos/UART/modem_control.v
add_fileset_file reg_control.v VERILOG PATH modulos/UART/reg_control.v
add_fileset_file select_read.v VERILOG PATH modulos/UART/select_read.v
add_fileset_file uart_interface.v VERILOG PATH modulos/UART/uart_interface.v TOP_LEVEL_FILE
add_fileset_file uart_rx.v VERILOG PATH modulos/UART/uart_rx.v
add_fileset_file uart_tx.v VERILOG PATH modulos/UART/uart_tx.v
add_fileset_file uart_unit.v VERILOG PATH modulos/UART/uart_unit.v

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL uart_interface
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file baud_rate_gen.v VERILOG PATH modulos/UART/baud_rate_gen.v
add_fileset_file fifo_cir.v VERILOG PATH modulos/UART/fifo_cir.v
add_fileset_file interrupt_control.v VERILOG PATH modulos/UART/interrupt_control.v
add_fileset_file modem_control.v VERILOG PATH modulos/UART/modem_control.v
add_fileset_file reg_control.v VERILOG PATH modulos/UART/reg_control.v
add_fileset_file select_read.v VERILOG PATH modulos/UART/select_read.v
add_fileset_file uart_interface.v VERILOG PATH modulos/UART/uart_interface.v
add_fileset_file uart_rx.v VERILOG PATH modulos/UART/uart_rx.v
add_fileset_file uart_tx.v VERILOG PATH modulos/UART/uart_tx.v
add_fileset_file uart_unit.v VERILOG PATH modulos/UART/uart_unit.v


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
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint ""
set_interface_property interrupt_sender associatedClock clock
set_interface_property interrupt_sender associatedReset reset_sink
set_interface_property interrupt_sender bridgedReceiverOffset ""
set_interface_property interrupt_sender bridgesToReceiver ""
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender irq irq Output 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset_sink
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitStates 0
set_interface_property avalon_slave_0 readWaitTime 0
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 chipselect chipselect Input 1
add_interface_port avalon_slave_0 address address Input 2
add_interface_port avalon_slave_0 writedata writedata Input 32
add_interface_port avalon_slave_0 readdata readdata Output 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point rts
# 
add_interface rts conduit end
set_interface_property rts associatedClock clock
set_interface_property rts associatedReset ""
set_interface_property rts ENABLED true
set_interface_property rts EXPORT_OF ""
set_interface_property rts PORT_NAME_MAP ""
set_interface_property rts CMSIS_SVD_VARIABLES ""
set_interface_property rts SVD_ADDRESS_GROUP ""

add_interface_port rts rts writeresponsevalid_n Output 1


# 
# connection point cts
# 
add_interface cts conduit end
set_interface_property cts associatedClock clock
set_interface_property cts associatedReset ""
set_interface_property cts ENABLED true
set_interface_property cts EXPORT_OF ""
set_interface_property cts PORT_NAME_MAP ""
set_interface_property cts CMSIS_SVD_VARIABLES ""
set_interface_property cts SVD_ADDRESS_GROUP ""

add_interface_port cts cts beginbursttransfer Input 1


# 
# connection point rx
# 
add_interface rx conduit end
set_interface_property rx associatedClock clock
set_interface_property rx associatedReset ""
set_interface_property rx ENABLED true
set_interface_property rx EXPORT_OF ""
set_interface_property rx PORT_NAME_MAP ""
set_interface_property rx CMSIS_SVD_VARIABLES ""
set_interface_property rx SVD_ADDRESS_GROUP ""

add_interface_port rx rx beginbursttransfer Input 1


# 
# connection point tx
# 
add_interface tx conduit end
set_interface_property tx associatedClock clock
set_interface_property tx associatedReset ""
set_interface_property tx ENABLED true
set_interface_property tx EXPORT_OF ""
set_interface_property tx PORT_NAME_MAP ""
set_interface_property tx CMSIS_SVD_VARIABLES ""
set_interface_property tx SVD_ADDRESS_GROUP ""

add_interface_port tx tx writeresponsevalid_n Output 1

