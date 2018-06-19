`timescale 1 ns / 100 ps

module Coffee_Vending_machine_top(

	FPGA_RSTB ,
	FPGA_CLK  ,
	DIP_SW    ,
	DIGIT     ,
	SEG_A     ,
	SEG_B     ,
	SEG_C     ,
	SEG_D     ,
	SEG_E     ,
	SEG_F     ,
	SEG_G     ,
	SEG_DP    ,
	LED

	);

/*************************************************************
** Port Define Area                                         **
*************************************************************/
input 	     FPGA_RSTB ;
input 	     FPGA_CLK  ;
input  [4:0] DIP_SW    ;
output [5:0] DIGIT     ;
output       SEG_A     ;
output       SEG_B     ;
output       SEG_C     ;
output       SEG_D     ;
output       SEG_E     ;
output       SEG_F     ;
output       SEG_G     ;
output       SEG_DP    ;
output [1:0] LED;

wire key_input_money;
wire key_req_change;
wire key_click_black;
wire key_click_cream;
wire key_click_cream_sugar;
wire [4:0] Money;
reg [6:0] seg;
wire [1:0] LED;
reg  [19:0]   cnt_100        ;
reg           clk_100        ;
wire load_100 = (cnt_100 == 20'h7a11f) ? 1'b1 : 1'b0;

assign LED = {~DIP_SW[0],key_input_money};
assign DIGIT = 6'b111111;

//Edge detection
Edge_Detect u0 
	   (
      .RSTB          (  FPGA_RSTB    ),
      .CLK           (  clk_100     ),
      .D_IN          (  ~DIP_SW[0]    ),
      .D_OUT         (  key_input_money   )
     );

Edge_Detect u1
	   (
      .RSTB          (  FPGA_RSTB    ),
      .CLK           (  clk_100     ),
      .D_IN          (  ~DIP_SW[1]    ),
      .D_OUT         (  key_req_change   )
     );

Edge_Detect u2
	   (
      .RSTB          (  FPGA_RSTB    ),
      .CLK           (  clk_100     ),
      .D_IN          (  ~DIP_SW[2]    ),
      .D_OUT         (  key_click_black   )
     );

// Add Edge_Detect for key_click_cream
Edge_Detect u3
(
	.RSTB(FPGA_RSTB),
	.CLK(clk_100),
	.D_IN(~DIP_SW[3]),
	.D_OUT(key_click_cream)
);

Edge_Detect u4
(
	.RSTB(FPGA_RSTB),
	.CLK(clk_100),
	.D_IN(~DIP_SW[4]),
	.D_OUT(key_click_cream_sugar)
);



Coffee_Vending_machine ucoffee_vending_machine(
//Input
	.Clock(clk_100),
	.nReset(FPGA_RSTB),
	.Input_Money(key_input_money),
	.Req_Change(key_req_change),
	.Click_Black(key_click_black),
	.Click_Cream(key_click_cream),
 //need to connect
	.Click_Cream_Sugar(key_click_cream_sugar),
 // not connected
//Output	
	.Money(Money),
	.Change(Change),
	.Coffee(Coffee),
	.Water(Water),
	.Cream(Cream),
	.Sugar(Sugar)

	);
/*************************************************************
** Key Select                                               **
*************************************************************/
always @(Money[3:0]) begin
   case (Money[3:0])
  		4'h0   : seg = 7'b1111110;
			4'h1   : seg = 7'b0110000;
			4'h2   : seg = 7'b1101101;
			4'h3   : seg = 7'b1111001;
			4'h4   : seg = 7'b0110011;
			4'h5   : seg = 7'b1011011;
			4'h6   : seg = 7'b1011111;
			4'h7   : seg = 7'b1110010;
			4'h8   : seg = 7'b1111111;
			4'h9   : seg = 7'b1111011;
			4'ha   : seg = 7'b1111101;
			4'hb   : seg = 7'b0011111;
			4'hc   : seg = 7'b1001110;
			4'hd   : seg = 7'b0111101;
			4'he   : seg = 7'b1001111;
			4'hf   : seg = 7'b1000111;
			default: seg = ~7'b0000000;
		endcase
end
/*************************************************************
** Segment Data                                            **
*************************************************************/
   
assign SEG_A = seg[6];
assign SEG_B = seg[5];
assign SEG_C = seg[4];
assign SEG_D = seg[3];
assign SEG_E = seg[2];
assign SEG_F = seg[1];
assign SEG_G = seg[0];

/*************************************************************
** 100Hz Generation                                         **
*************************************************************/
always @(posedge FPGA_CLK or negedge FPGA_RSTB ) begin
    if (~FPGA_RSTB) begin
       cnt_100 <= 20'h00000;
       clk_100 <= 1'b0;
    end
    else begin
         if (load_100) begin
         		cnt_100 <= 20'h00000;
         		clk_100    <= (~clk_100);    
         end
         else begin 
            cnt_100 <= cnt_100 + 1'b1;  
         		clk_100 <= clk_100;
         end
    end
end
  endmodule
