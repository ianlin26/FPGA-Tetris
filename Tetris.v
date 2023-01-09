module Tetris(
    output reg [7:0] DATA_R, DATA_G, DATA_B ,output reg [3:0] COMM,output reg [6:0] LED_Time_out, output reg [3:0] COMT,output reg [15:0] LED_Point_out,output reg dot,
    input CLK,input buttenR,buttenL,buttenT,buttenD);
//value
    reg [3:0] shape[6:0][3:0][3:0];
    initial 
        begin
			//7 shape for 4 state
            shape[0][0][0]=4'b1111;shape[0][0][1]=4'b0000;shape[0][0][2]=4'b0000;shape[0][0][3]=4'b0000;shape[0][1][0]=4'b1000;shape[0][1][1]=4'b1000;shape[0][1][2]=4'b1000;shape[0][1][3]=4'b1000;shape[0][2][0]=4'b1111;shape[0][2][1]=4'b0000;shape[0][2][2]=4'b0000;shape[0][2][3]=4'b0000;shape[0][3][0]=4'b1000;shape[0][3][1]=4'b1000;shape[0][3][2]=4'b1000;shape[0][3][3]=4'b1000;
            shape[1][0][0]=4'b1100;shape[1][0][1]=4'b1100;shape[1][0][2]=4'b0000;shape[1][0][3]=4'b0000;shape[1][1][0]=4'b1100;shape[1][1][1]=4'b1100;shape[1][1][2]=4'b0000;shape[1][1][3]=4'b0000;shape[1][2][0]=4'b1100;shape[1][2][1]=4'b1100;shape[1][2][2]=4'b0000;shape[1][2][3]=4'b0000;shape[1][3][0]=4'b1100;shape[1][3][1]=4'b1100;shape[1][3][2]=4'b0000;shape[1][3][3]=4'b0000;
            shape[2][0][0]=4'b1110;shape[2][0][1]=4'b0100;shape[2][0][2]=4'b0000;shape[2][0][3]=4'b0000;shape[2][1][0]=4'b0100;shape[2][1][1]=4'b1100;shape[2][1][2]=4'b0100;shape[2][1][3]=4'b0000;shape[2][2][0]=4'b0100;shape[2][2][1]=4'b1110;shape[2][2][2]=4'b0000;shape[2][2][3]=4'b0000;shape[2][3][0]=4'b1000;shape[2][3][1]=4'b1100;shape[2][3][2]=4'b1000;shape[2][3][3]=4'b0000;
            shape[3][0][0]=4'b1110;shape[3][0][1]=4'b1000;shape[3][0][2]=4'b0000;shape[3][0][3]=4'b0000;shape[3][1][0]=4'b1100;shape[3][1][1]=4'b0100;shape[3][1][2]=4'b0100;shape[3][1][3]=4'b0000;shape[3][2][0]=4'b0010;shape[3][2][1]=4'b1110;shape[3][2][2]=4'b0000;shape[3][2][3]=4'b0000;shape[3][3][0]=4'b1000;shape[3][3][1]=4'b1000;shape[3][3][2]=4'b1100;shape[3][3][3]=4'b0000;
            shape[4][0][0]=4'b1110;shape[4][0][1]=4'b0010;shape[4][0][2]=4'b0000;shape[4][0][3]=4'b0000;shape[4][1][0]=4'b0100;shape[4][1][1]=4'b0100;shape[4][1][2]=4'b1100;shape[4][1][3]=4'b0000;shape[4][2][0]=4'b1000;shape[4][2][1]=4'b1110;shape[4][2][2]=4'b0000;shape[4][2][3]=4'b0000;shape[4][3][0]=4'b1100;shape[4][3][1]=4'b1000;shape[4][3][2]=4'b1000;shape[4][3][3]=4'b0000;
            shape[5][0][0]=4'b1100;shape[5][0][1]=4'b0110;shape[5][0][2]=4'b0000;shape[5][0][3]=4'b0000;shape[5][1][0]=4'b0100;shape[5][1][1]=4'b1100;shape[5][1][2]=4'b1000;shape[5][1][3]=4'b0000;shape[5][2][0]=4'b1100;shape[5][2][1]=4'b0110;shape[5][2][2]=4'b0000;shape[5][2][3]=4'b0000;shape[5][3][0]=4'b0100;shape[5][3][1]=4'b1100;shape[5][3][2]=4'b1000;shape[5][3][3]=4'b0000;
            shape[6][0][0]=4'b0110;shape[6][0][1]=4'b1100;shape[6][0][2]=4'b0000;shape[6][0][3]=4'b0000;shape[6][1][0]=4'b1000;shape[6][1][1]=4'b1100;shape[6][1][2]=4'b0100;shape[6][1][3]=4'b0000;shape[6][2][0]=4'b0110;shape[6][2][1]=4'b1100;shape[6][2][2]=4'b0000;shape[6][2][3]=4'b0000;shape[6][3][0]=4'b1000;shape[6][3][1]=4'b1100;shape[6][3][2]=4'b0100;shape[6][3][3]=4'b0000;
            //7shape's high for 4 state
        end
    reg [1:0]stage;
    int shape_state,o_shape_state;
    int x,y,o_x,o_y,y_need_fresh,high,o_t_y,r_r;
    int flag,flag2,flag_l,flag_r,flag_t,restart,countline;
    int t;
    int left,right,down,turn,controller,f_right,f_left,f_turn,f_down;
    reg can_right,can_left,can_rotate,need_new_shape;
    reg [5:0]timer_s,timer_m;//display
    reg [1:0] Count_COM;//display
    reg [3:0] LED_BCD;//display
    reg [15:0] point;
    //map
    reg [7:0]LED_map[7:0];
    reg [7:0]map[7:0];
    reg able;
    bit [2:0] cnt;
    //temp fo count
    int i,j,k,s,o_s,o_i,o_j;
//clock
    clock1Hz F0(CLK, CLK_1Hz);
    clock1000Hz F1(CLK, CLK_1000Hz);
    clock60Hz F2(CLK, CLK_60Hz);
    clock5Hz F3(CLK, CLK_5Hz);
    clock2Hz F4(CLK, CLK_2Hz);
    //random
    reg[9:0] random;
    always@(posedge CLK)
    begin
        if(random >= 231) random <= 0;
        random <= random+1+right+left+down;
    end
	//init
    initial 
        begin
            need_new_shape = 1;
            timer_m=5'b0;
            timer_s=5'b0;
            dot = 0;
            for (i=0; i<8; i=i+1)
                LED_map[i] <= 8'b00011111;
            LED_map[4][4]=0;
            left = 0;
            right = 0;
            turn = 0;
            able=1'b1;
            //temp
            restart = 0;
        end
    always@(posedge CLK)
    begin
        if(controller==13)
            controller <= 0;
        else controller <= controller + 1;
    end
//start the game

    always@(posedge CLK)
    begin
        if(controller==1 && restart == 0)//change map
        begin
            if(flag2)
                for(i=0;i<4;i++)
                    for (j=0;j<4;j++)
                        if(shape[o_s][o_shape_state][i][3-j])
                            LED_map[o_x+i][o_y+j]=shape[o_s][o_shape_state][i][3-j];
            o_s = s;
            o_x = x;
            o_y = y;
            o_shape_state = shape_state;
            if(flag2)
                for(i=0;i<4;i++)
                    for (j=0;j<4;j++)
                        if(shape[s][shape_state][i][3-j])
                            LED_map[x+i][y+j]=~shape[s][shape_state][i][3-j];

            if(!flag)
            begin
                flag2=0;
                o_x=-10;
                o_y=-10;
            end
        end
        else if(controller==2)//new shape
        begin
            if(need_new_shape)
            begin
                s = (random+s)%7;
                need_new_shape = 0;
                shape_state = 0;
                y_need_fresh = 1;
                x = 3;
            end
            if(y==-3)
            begin
                y_need_fresh = 0;
                flag2=1;
            end
        end
        else if(controller==4 && restart == 0)//move
        begin
            if(left && !f_left)
            begin
                x = x - 1;
                f_left = 1;
            end
            else if(!left && f_left)
                f_left = 0;  
            if(right && !f_right)
            begin
                x = x + 1;
                f_right = 1;
            end
            else if(!right && f_right)
                f_right = 0;
            if(turn && !f_turn)
            begin
                shape_state = (shape_state  + 1) % 4;
                f_turn = 1;
            end
            else if(!turn && f_turn)
                f_turn = 0;
        end 
        else if(controller==3 && restart == 0)//check for end
        begin
            if(y==-3)flag = 1;
            for(i=0 ;i<4 && flag ;i++)
                for (j=3;j>=0;j--)
                    if(shape[s][shape_state][i][3-j] && y+j>=0)
                    begin
                        if( LED_map[x+i][y+j+1]==0 || y + j == 7) 
                        begin
                            flag=0;
                            need_new_shape =1;
                        end
                        break;
                    end  
        end
        else if(controller==5)//add point
        begin
            if(y_need_fresh)
            begin
                countline = 0;
                for(k=7;k>0;k--)
                    if(!LED_map[0][k] && !LED_map[1][k] && !LED_map[2][k] && !LED_map[3][k] && !LED_map[4][k] && !LED_map[5][k] && !LED_map[6][k] && !LED_map[7][k])
                    begin
                        for(i=0 ;i <8 ;i++)
                            for(j = k; j > 0; j--)
                                LED_map[i][j] = LED_map[i][j-1];
                        countline++;
                    end
                point = point + countline;
                if(countline==4)
                    point = point + 4;
                if(!LED_map[0][0] || !LED_map[1][0] || !LED_map[2][0] || !LED_map[3][0] || !LED_map[4][0] || !LED_map[5][0] || !LED_map[6][0] || !LED_map[7][0])
                begin
                    restart =1;
                    o_t_y = -3;
                end
            end
        end
        else if(controller==6)//can
        begin
            flag_l = 1;
            for(j=0; j<4 && flag_l ;j++)
                for (i = 0; i < 4; i++)
                    if(shape[s][shape_state][i][3-j] && y+j>=0)
                    begin
                        if(x>0 && LED_map[x+i-1][y+j]==0 )
                        begin
                            flag_l=0;
                        end
                        break;
                    end
            if(x <= 0||!flag_l)
                can_left = 0;
            else
                can_left = 1;
            flag_r = 1;
            if(s==0)
            begin
                if((shape_state%2)==0) r_r=0;
                else r_r=3;
            end
            else if(s==1)
                r_r = 1;
            else
            begin
                if((shape_state%2)==0) r_r=1;
                else r_r=2;
            end
            for(j=0; j<4 && flag_r ;j++)
                for (i = 3; i >=0; i--)
                    if(shape[s][shape_state][i][3-j] && y+j>=0)
                    begin
                        if((x+i < 7 && LED_map[x+i+1][y+j] == 0)||x+i == 7)
                        begin
                            flag_r=0;
                        end
                        break;
                    end
            if(x+r_r >=7 || !flag_r)
                can_right = 0;
            else
                can_right = 1;
            flag_t = 1;
            if(s==0)
            begin
                if((shape_state%2)==0) high=4;
                else high=1;
            end
            else if(s==1)
                high = 2;
            else
            begin
                if((shape_state%2)==0) high=3;
                else high=2;
            end
            for(j=0; j<4 && flag_t ;j++)
                for (i = 0; i <4; i++)
                    if(shape[s][shape_state][i][3-j] == 0 && shape[s][(shape_state+1)%4][i][3-j] == 1&& y+j>=0)
                    begin
                        if(x+high-1 <= 7 && LED_map[x+i][y+j] == 0)
                        begin
                            flag_t=0;
                        end
                    end
            if(x+high-1 >7 || !flag_t)
                can_rotate = 0;
            else
                can_rotate = 1;
        end
        else if(controller==7)//gameover
        begin
            if(restart == 1 && o_t_y == -3)
            begin
                y_need_fresh = 1;
                o_t_y++;
                x = -10;
            end
            else if(restart == 1 && y == -2)
                able=1'b0;
            else if(restart == 1 && y == -1)
                able=1'b1;
            else if(restart == 1 && y == 0)
            begin
                need_new_shape = 1;
                point = 0;
                for (i=0; i<8; i=i+1)
                    LED_map[i] <= 8'b11111111;
                restart = 0;
            end
        end 

    end
    
//TEMP
    int counter;
    /* always @(posedge CLK_1Hz)
    begin
        if(y == 7||y_need_fresh)
            y = -3;
        else
            y = y + 1; 
    end */
    always @(posedge CLK_5Hz)
    begin
        if(down)
            counter = counter+2;
        else
            counter++;
        if(counter>=4)
        begin
            if(y == 7||y_need_fresh)
                y = -3;
            else
                y = y + 1; 
            counter = counter % 4;
        end
    end
    always @(posedge CLK_5Hz)//get butten
    begin
        if(f_left)
            left=0;
        if(f_right)
            right=0;
        if(f_turn)
            turn=0;
        if(buttenL)
        begin
            if(can_left)
            begin
                left = 1;
            end
        end
        if(buttenR)
        begin
            if(can_right)
            begin
                right = 1;
            end
        end
        if(buttenT)
        begin
            if(can_rotate)
            begin
                turn = 1;
            end
        end
        down = buttenD;
    end


    



//display
    
    //LED8*8
    always @(posedge CLK_1000Hz) 
        begin
            if(cnt >= 7)    
                cnt =0;
            else
                cnt = cnt+1;
            COMM = {able, cnt};
            DATA_R = LED_map[cnt];
            DATA_G = LED_map[cnt];
            DATA_B = LED_map[cnt];
           
        end

    //LED 7 seg
    always @(*) 
        case(LED_BCD)
                4'b0000: LED_Time_out = 7'b0000001; // "0"  
                4'b0001: LED_Time_out = 7'b1001111; // "1" 
                4'b0010: LED_Time_out = 7'b0010010; // "2" 
                4'b0011: LED_Time_out = 7'b0000110; // "3" 
                4'b0100: LED_Time_out = 7'b1001100; // "4" 
                4'b0101: LED_Time_out = 7'b0100100; // "5" 
                4'b0110: LED_Time_out = 7'b0100000; // "6" 
                4'b0111: LED_Time_out = 7'b0001111; // "7" 
                4'b1000: LED_Time_out = 7'b0000000; // "8"  
                4'b1001: LED_Time_out = 7'b0000100; // "9" 
                default: LED_Time_out = 7'b1111111;
            endcase
    
    always @(posedge CLK_1Hz)
    begin
        if(restart == 1)
            begin timer_m = 0; timer_s = 0; end
        else if(timer_s >= 59)
            begin timer_m = timer_m + 1; timer_s = 0; end
        else timer_s = timer_s + 1;   
    end
    always @(posedge CLK_2Hz)
        dot = ~dot;
    always @(posedge CLK_1000Hz)
    begin
        case(Count_COM)
            0: begin COMT = 4'b1110; LED_BCD = left/* timer_m / 10 */ ;Count_COM = Count_COM + 1;end
            1: begin COMT = 4'b1101; LED_BCD = can_left ;Count_COM = Count_COM + 1;end
            2: begin COMT = 4'b1011; LED_BCD = can_right ;Count_COM = Count_COM + 1;end
            3: begin COMT = 4'b0111; LED_BCD = can_rotate ; Count_COM = 0;end
        endcase
        
    end
    //LED array
    always @(posedge CLK_60Hz)
    begin
        LED_Point_out = point;
    end 
endmodule



module clock1000Hz(input CLK, output reg CLK_1000Hz);
   reg [24:0] Count;
   always @(posedge CLK)
      begin 
          if(Count > (25000000/1000))//1000Hz
             begin
                Count <= 25'b0;
                CLK_1000Hz <= ~CLK_1000Hz;
             end
          else
          Count <= Count + 1'b1;
      end
endmodule

module clock1Hz (input CLK, output reg CLK_1Hz);
   reg [24:0] Count;
   always @(posedge CLK)
      begin 
          if(Count > (25000000/1))//1Hz
             begin
                Count <= 25'b0;
                CLK_1Hz <= ~CLK_1Hz;
             end
          else
          Count <= Count + 1'b1;
      end
endmodule

module clock60Hz (input CLK, output reg CLK_60Hz);
   reg [24:0] Count;
   always @(posedge CLK)
      begin 
          if(Count > (25000000/60))//60Hz
             begin
                Count <= 25'b0;
                CLK_60Hz <= ~CLK_60Hz;
             end
          else
          Count <= Count + 1'b1;
      end
endmodule

module clock5Hz (input CLK, output reg CLK_5Hz);
   reg [24:0] Count;
   always @(posedge CLK)
      begin 
          if(Count > (25000000/5))//5Hz
             begin
                Count <= 25'b0;
                CLK_5Hz <= ~CLK_5Hz;
             end
          else
          Count <= Count + 1'b1;
      end
endmodule
module clock2Hz (input CLK, output reg CLK_2Hz);
   reg [24:0] Count;
   always @(posedge CLK)
      begin 
          if(Count > (25000000/2))//2Hz
             begin
                Count <= 25'b0;
                CLK_2Hz <= ~CLK_2Hz;
             end
          else
          Count <= Count + 1'b1;
      end
endmodule