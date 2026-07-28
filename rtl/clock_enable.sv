`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 08:06:00 PM
// Design Name: 
// Module Name: clock_enable
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_enable(
        
        input logic clk,
        input logic reset,
        output logic one_second_tick
        
);

logic [26:0] counter;

always_ff @(posedge clk)begin
    if(reset) begin         
        counter <= 27'd0;
        one_second_tick <= 1'b0;
     end
     
     else if (counter == 27'd99_999_999) begin
     
        counter <= 27'd0;
        one_second_tick <= 1'b1;
     end
     
     else begin
            counter <= counter + 1'b1;
            one_second_tick <= 1'b0;
     end
     
end
     

endmodule


