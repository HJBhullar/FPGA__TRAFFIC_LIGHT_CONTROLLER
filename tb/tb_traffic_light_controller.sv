module tb_traffic_light_controller;

    logic clk;
    logic reset;
    logic ped_button;
    logic emergency;

    logic main_red;
    logic main_yellow;
    logic main_green;
    logic side_red;
    logic side_yellow;
    logic side_green;
    logic ped_walk;

    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .ped_button(ped_button),
        .emergency(emergency),
        .main_red(main_red),
        .main_yellow(main_yellow),
        .main_green(main_green),
        .side_red(side_red),
        .side_yellow(side_yellow),
        .side_green(side_green),
        .ped_walk(ped_walk)
    );

endmodule
