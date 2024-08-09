
module controller_bus #(
    parameter NUM_BUTTONS = 8  // Parâmetro para definir o número de botões
) (
    input  wire [31:0]                register_1, // Array de registradores
    input  wire [31:0]                register_2, // Array de registradores
	output wire                       CRR,                          // Clock Reset Register
    output wire [1:0]                 TR,                           // Time Register
    output wire [NUM_BUTTONS - 1:0]   RSTR,                         // Reset Register
    output wire [NUM_BUTTONS - 1:0]   NCR,                          // Noise Cancelling Register
    output wire [2*NUM_BUTTONS - 1:0] CCR                           // Capture Control Register
);

    assign CRR  = register_1[0]; // Clock Reset Register
    assign TR   = register_1[2:1]; // Time Register
    assign NCR  = {register_2[3],   register_1[30],    register_1[26],    register_1[22],    register_1[18],    register_1[14],    register_1[10],  register_1[6]}; // Noise Cancelling Register
    assign CCR  = {register_2[2:1], register_1[29:28], register_1[25:24], register_1[21:20], register_1[17:16], register_1[13:12], register_1[9:8], register_1[5:4]}; // Capture Control Register
    assign RSTR = {register_2[0],   register_1[27],    register_1[23],    register_1[19],    register_1[15],    register_1[11],    register_1[7],   register_1[3]}; // Reset Register

endmodule
