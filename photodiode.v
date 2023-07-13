module photodiode (
  input clk,
  input reset,
  input pd_sensor_data,
  output reg pd_detected,
  output reg led
  );


  always @(posedge clk or posedge reset) begin
    if (reset==1) begin
      pd_detected <= 0;
		led <= 0;
    end
    else begin
      if (pd_sensor_data==1) begin
        pd_detected <= 1;
		  led <= 1;
    end
	 else begin
		  pd_detected<=0;
		 led<=0;
	 end
	 end
  end
  

endmodule