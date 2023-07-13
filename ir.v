module ir (
  input wire clk,
  input wire reset,
  input wire ir_sensor_data,
  output reg ir_detected,
  output reg led
  );


  always @(posedge clk or posedge reset) begin
    if (reset==1) begin
      ir_detected <= 0;
		led <= 0;
    end
    else begin
      if (ir_sensor_data==0) begin
        ir_detected <= 1;
		  led <= 1;
    end
	 else begin
		  ir_detected<=0;
		 led<=0;
	 end
	 end
  end
  

endmodule