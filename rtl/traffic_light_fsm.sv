`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 07/21/2026 09:49:03 PM
// Design Name: 
// Module Name: traffic_light_fsm
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_fsm(

    input logic clk,
    input logic reset,
    input logic one_second_tick,
    
    output logic road_a_red,
    output logic road_a_yellow,
    output logic road_a_green,
    
    output logic road_b_red,
    output logic road_b_yellow,
    output logic road_b_green

    );
    
typedef enum logic [2:0] {

    A_GREEN,
    A_YELLOW,
    ALL_RED_1,
    B_GREEN,
    B_YELLOW,
    ALL_RED_2
    
} state_t;

state_t current_state;
state_t next_state;

localparam int GREEN_TIME = 60;
localparam int YELLOW_TIME = 5;
localparam int ALL_RED_TIME = 2;

logic [5:0] second_count;

always_ff @(posedge clk) begin
    
        if (reset)
            current_state <= A_GREEN;
        
        else
            current_state <= next_state;
            
end

//state and timer

always_ff @(posedge clk) begin
    if (reset) begin
        second_count <= 6'd0;
        
    end
    else if (current_state != next_state) begin
            second_count <= 6'd0;
            
    end
    else if (one_second_tick) begin
        second_count <= second_count + 6'd1;
        
    end
    
   end

// Next-state logic
always_comb begin
    next_state = current_state;
    
    
    case (current_state)
    
        A_GREEN: begin
           if (one_second_tick && second_count == GREEN_TIME -1)
                next_state = A_YELLOW;
                
            end
            
        A_YELLOW: begin
          if (one_second_tick && second_count == YELLOW_TIME - 1)
                next_state = ALL_RED_1;     
          end
                
        ALL_RED_1: begin
          if (one_second_tick && second_count == ALL_RED_TIME - 1)
                next_state = B_GREEN;
          end
          
         B_GREEN: begin
          if (one_second_tick && second_count == GREEN_TIME - 1)
                next_state = B_YELLOW;
          end
          
        B_YELLOW: begin
          if (one_second_tick && second_count == YELLOW_TIME - 1)
                next_state = ALL_RED_2;
          end
          
        ALL_RED_2: begin
            if(one_second_tick && second_count == ALL_RED_TIME - 1)
                next_state = A_GREEN;
            end
            
         default: begin
            next_state = A_GREEN;
         end
         
     endcase
        
  end       

// Moore output logic

always_comb begin

    road_a_red = 1'b0;
    road_a_yellow = 1'b0;
    road_a_green = 1'b0;
    
    road_b_red = 1'b0;
    road_b_yellow = 1'b0;
    road_b_green = 1'b0;
    
    case (current_state)
        
        A_GREEN: begin
            road_a_green = 1'b1;
            road_b_red   = 1'b1;
         end
           
        A_YELLOW: begin
            road_a_yellow = 1'b1;
            road_b_red    = 1'b1;
        end
        
        ALL_RED_1: begin
            road_a_red = 1'b1;
            road_b_red = 1'b1;
        end
        
        B_GREEN: begin
            road_b_green = 1'b1;
            road_a_red   = 1'b1;      
        end
        
        B_YELLOW: begin
            road_b_yellow = 1'b1;
            road_a_red    = 1'b1;
        end
        
        ALL_RED_2: begin
            road_a_red = 1'b1;
            road_b_red = 1'b1;
        end
        
        
        
        
        default: begin
            road_a_red = 1'b1;
            road_b_red = 1'b1;
            
        end
        
      endcase
   end
 









endmodule
