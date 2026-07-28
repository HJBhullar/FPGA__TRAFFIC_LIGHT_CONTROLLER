`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 09:39:59 PM
// Design Name: 
// Module Name: traffic_light_top
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


module traffic_light_top(

    input logic clk_100mhz,
    input logic reset_btn,
    
    output logic road_a_red,
    output logic road_a_yellow,
    output logic road_a_green,
    
    output logic road_b_red,
    output logic road_b_yellow,
    output logic road_b_green

    );
    
    logic one_second_tick;
    
    clock_enable clock_enable_inst (
    .clk           (clk_100mhz),
    .reset          (reset_btn),
    .one_second_tick    (one_second_tick)
    
    );
    
    traffic_light_fsm traffic_light_fsm_inst (
    
    .clk                (clk_100mhz),
    .reset              (reset_btn),
    .one_second_tick    (one_second_tick),
    
    .road_a_red         (road_a_red),
    .road_a_yellow      (road_a_yellow),
    .road_a_green       (road_a_green),
    
    .road_b_red         (road_b_red),
    .road_b_yellow      (road_b_yellow),
    .road_b_green       (road_b_green)
    
    );
endmodule
