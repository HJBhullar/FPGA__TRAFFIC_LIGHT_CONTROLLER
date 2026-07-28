`timescale 1ns / 1ps

module traffic_light_top_tb;

    logic clk_100mhz;
    logic reset_btn;

    logic road_a_red;
    logic road_a_yellow;
    logic road_a_green;

    logic road_b_red;
    logic road_b_yellow;
    logic road_b_green;

    traffic_light_top dut (
        .clk_100mhz    (clk_100mhz),
        .reset_btn     (reset_btn),

        .road_a_red    (road_a_red),
        .road_a_yellow (road_a_yellow),
        .road_a_green  (road_a_green),

        .road_b_red    (road_b_red),
        .road_b_yellow (road_b_yellow),
        .road_b_green  (road_b_green)
    );

    initial begin
        clk_100mhz = 1'b0;
        forever #5 clk_100mhz = ~clk_100mhz;
    end

    initial begin
        reset_btn = 1'b1;
        #100;
        reset_btn = 1'b0;

        #5000;
        $finish;
    end

endmodule