
//////////////////////////////////////////////////////////////////////////////
//
//  Libertron Co., LTD. 2010                 www.libertron.com
//
//  SL2_Education LAB.
//
//////////////////////////////////////////////////////////////////////////////
//
//  File name   :     Edge_Detect.v
//
//  Description :     
//
//
//  Author      :     Libertron R&D Lab.
//
//  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are
//              provided to you "as is". Libertron and its licensors makeand you
//              receive no warranties or conditions, express, implied,
//              statutory or otherwise, and Libertron specifically disclaims any
//              implied warranties of merchantability, non-infringement,or
//              fitness for a particular purpose. Libertron does notwarrant that
//              the functions contained in these designs will meet your
//              requirements, or that the operation of these designswill be
//              uninterrupted or error free, or that defects in theDesigns
//              will be corrected. Furthermore, Libertron does not warrantor
//              make any representations regarding use or the results ofthe
//              use of the designs in terms of correctness, accuracy,
//              reliability, or otherwise.
//
//              LIMITATION OF LIABILITY. In no event will Libertron or its
//              licensors be liable for any loss of data, lost profits,cost
//              or procurement of substitute goods or services, or forany
//              special, incidental, consequential, or indirect damages
//              arising from the use or operation of the designs or
//              accompanying documentation, however caused and on anytheory
//              of liability. This limitation will apply even if Libertron
//              has been advised of the possibility of such damage. This
//              limitation shall apply not-withstanding the failure ofthe
//              essential purpose of any limited remedies herein.
//
//  Copyright @2010 Libertron Co., LTD.
//  All rights reserved
//
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1ps

module Edge_Detect 
     ( 
			RSTB  ,
			CLK   ,
			D_IN  ,
			D_OUT  
		  );
/*************************************************************
** Port Define Area                                         **
*************************************************************/
input			    RSTB  ;
input			    CLK   ;
input			    D_IN  ;
output			  D_OUT ;
/*************************************************************
** Parameter Define Area                                    **
*************************************************************/

/*************************************************************
** Register Define Area                                     **
*************************************************************/
reg         prev_data;
reg         D_OUT    ;
/*************************************************************
** integer Define Area                                     **
*************************************************************/

/*************************************************************
** Wire Define Area                                         **
*************************************************************/

/*************************************************************
** tmp count                                               **
*************************************************************/
always @(posedge CLK or negedge RSTB ) begin
    if (~RSTB) begin
       D_OUT     <= 1'b0;
       prev_data <= 1'b0;
    end
    else begin
         prev_data <= D_IN;
         if ((~prev_data) & D_IN) begin
            D_OUT <= 1'b1;
         end
         else begin
         		D_OUT <= 1'b0;
         end
    end
end
/*************************************************************
** Data Output                                              **
*************************************************************/

endmodule