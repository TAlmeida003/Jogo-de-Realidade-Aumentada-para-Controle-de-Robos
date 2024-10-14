module comparator #(parameter size_reg = 32, size_check = 20 ,x_inicio = 19, x_final = 28, y_inicio = 9, y_final = 18, spriteLine = 20)
(
	input  wire [size_reg-1:0]   rg,
	input  wire [size_check-1:0] check,
	input  wire                  compare,
	output reg 					 result
);


always @(*) begin
	result = 1'b0;
	if(!compare) begin	//caso esteja no modo de leitura do banco de registradores
		if(rg[31:29] == 3'b001) begin //registrador está sendo utilizado 
			if( (check[19:10] >= rg[x_final:x_inicio]) && (check[19:10] < (rg[x_final:x_inicio] + spriteLine) ) ) begin
				if( (check[9:0] >= rg[y_final:y_inicio]) && (check[9:0] < (rg[y_final:y_inicio] + spriteLine) ) ) begin
					result = 1'b1;
				end
			end
		end
	end
end

endmodule
