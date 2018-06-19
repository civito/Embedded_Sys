`timescale 1 ns / 100 ps

module Test();

reg	Clock;
//wire	nReset;
reg	nReset;
reg	Input_Money;
reg	Req_Change;
reg	Click_Black;
reg	Click_Cream;
reg	Click_Cream_Sugar;
//Output	
wire	[4:0]	Money;
wire	[4:0]	Change;
wire		Coffee;
wire	Water;
wire	Cream;
wire	Sugar;

initial
	begin
		#0 nReset = 1'b0;	 
    #100 nReset = 1'b1;
	end

initial
	begin
#0      Input_Money = 1'b0;
#0      Req_Change =0;
#0      Click_Black = 0;
#0      Click_Cream = 0;
#0      Click_Cream_Sugar = 0;
#500    Input_Money = 1'b1;
#2000   Input_Money = 1'b0;	  
#1000   Click_Black = 1;	 
#100    Click_Black = 0;	  
#2500   Input_Money = 1'b1;
#100    Input_Money = 1'b0;
#100    Click_Black = 1;
#100    Click_Black = 0;
#500 	Input_Money = 1'b1;
#800     Input_Money = 1'b0;	
#300 	Click_Black = 1;	  
#100 	Click_Black = 0;
#500 	Click_Cream = 1;
#100 	Click_Cream = 0;
#500 	Click_Cream_Sugar = 1;
#100 	Click_Cream_Sugar = 0;		 
	Click_Cream = 1;	
 	Input_Money = 1'b1;
#100	Input_Money = 1'b0;
          Click_Cream = 0;
#1000 	Input_Money = 1'b1;
#800     Input_Money = 1'b0;	  
#100     Req_Change =1;
#100     Req_Change =0;
	end
		
  initial Clock = 1'b0;
  always #50 Clock = !Clock;

initial
  begin
    #20000;
    $finish;
  end


Coffee_Vending_machine u1(
//Input
	.Clock			(Clock),
	.nReset			(nReset),
	.Input_Money		(Input_Money),
	.Req_Change		(Req_Change),
	.Click_Black		(Click_Black),
	.Click_Cream		(Click_Cream),
	.Click_Cream_Sugar	(Click_Cream_Sugar),
//Output	
	.Money			(Money),
	.Change			(Change),
	.Coffee			(Coffee),
	.Water			(Water),
	.Cream			(Cream),
	.Sugar			(Sugar)
	);

endmodule
