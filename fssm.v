module fssm(
  input wire clk,
  input wire reset,
  input wire ir_sensor_data,
  input wire pd_sensor_data,
  input wire sound_data,
  output buzzer_trigger,
  output pd_detected,
  output ir_detected
);

  // FSM states
  parameter STATE0 = 2'b00;
  parameter STATE1 = 2'b01;
  parameter STATE2 = 2'b10;
  parameter STATE3 = 2'b11;

  reg [1:0] state;
  reg buzz_sig;
  

  // Instantiate the modules
  
  photodiode pd_module(.clk(clk), .reset(reset), .pd_sensor_data(pd_sensor_data), .pd_detected(pd_detected));

  
  ir ir_module(.clk(clk), .reset(reset), .ir_sensor_data(ir_sensor_data), .ir_detected(ir_detected));
  

  // FSM
  always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
      state <= STATE0;
    end
    else begin
      case (state)
        STATE0: begin
		    buzz_sig = 0;
          if (ir_detected==1) begin
            state <= STATE1;
          end
			 else
			   state <= STATE0;
        end
        STATE1: begin
          if (pd_detected==1) begin
            state <= STATE2;
          end
			 else
			   state <= STATE1;
        end
        STATE2: begin
          if (sound_data==1) begin
            state <= STATE3;
          end
			 else
			   state <=STATE2;
        end
		  STATE3: begin
		      buzz_sig = 1;
			   state <=STATE3;
        end
      endcase
    end
  end
  assign buzzer_trigger = buzz_sig;
  
endmodule

