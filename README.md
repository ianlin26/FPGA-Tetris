# FPGA-Tetris

### Authors: 110321017 110321009 110321037

#### Input/Output unit:<br>
* 8x8 LED 矩陣，主畫面。<br>

* 七段顯示器，用來顯示已經過時間。<br>

* LED 陣列，用來計分。<br>

#### 功能說明:<br>
- 基本操作，如向左、向右、旋轉
- 讓所有方塊類型 I, O, T, L, I, Z, S 隨機生成
- 在墜落過程中，玩家可以控制方塊
- 如果與塊或底部碰撞，下降將停止
- 如果一行已滿，清除它並添加分數
- 如果堆疊到頂部，則結束遊戲

#### 程式模組說明:<br>
module Tetris(
    output reg [7:0] DATA_R, DATA_G, DATA_B ,output reg [3:0] COMM,output reg [6:0] LED_Time_out, output reg [3:0] COMT,output reg [15:0] LED_Point_out,output reg dot,
    input CLK,input buttenR,buttenL,buttenT,buttenD);
    
| input/output  | PIN | I/O | comment |
| --------------|-----|-----|---------|
CLK | PIN_22 | -- | clock (25 MHZ)
buttenL | PIN_10 | 4 BITS SW | Left button
buttenD | PIN_30 | 4 BITS SW | Down button
buttenT | PIN_28 | 4 BITS SW | Rotate button
buttenR | PIN_11 | 4 BITS SW | Right button
COMM[0] | PIN_128 | S0
COMM[1] | PIN_129 | S1
COMM[2] | PIN_132 | S2
COMM[3] | PIN_133 | EN | NO/OFF the LED line
COMT[0] | PIN_124 | COM1
COMT[1] | PIN_125 | COM2
COMT[2] | PIN_126 | COM3
COMT[3] | PIN_127 | COM4
DATA_B[0] | PIN_111 | CB1 |
DATA_B[1] | PIN_112 | CB2 |
DATA_B[2] | PIN_113 | CB3 |
DATA_B[3] | PIN_114 | CB4 |
DATA_B[4] | PIN_115 | CB5 |
DATA_B[5] | PIN_119 | CB6 |
DATA_B[6] | PIN_120 | CB7 |
DATA_B[7] | PIN_121 | CB8 |
DATA_G[0] | PIN_135 | CG1 |
DATA_G[1] | PIN_136 | CG2 |
DATA_G[2] | PIN_137 | CG3 |
DATA_G[3] | PIN_138 | CG4 |
DATA_G[4] | PIN_141 | CG5 |
DATA_G[5] | PIN_142 | CG6 |
DATA_G[6] | PIN_143 | CG7 |
DATA_G[7] | PIN_144 | CG8 |
DATA_R[0] | PIN_72 | CR1 |
DATA_R[1] | PIN_73 | CR2 |
DATA_R[2] | PIN_74 | CR3 |
DATA_R[3] | PIN_75 | CR4 |
DATA_R[4] | PIN_76 | CR5 |
DATA_R[5] | PIN_77 | CR6 |
DATA_R[6] | PIN_79 | CR7 |
DATA_R[7] | PIN_80 | CR8 |
LED_Point_out[0] | PIN_38 | LED1
LED_Point_out[1] | PIN_39 | LED2
LED_Point_out[2] | PIN_42 | LED3
LED_Point_out[3] | PIN_43 | LED4
LED_Point_out[4] | PIN_44 | LED5
LED_Point_out[5] | PIN_46 | LED6
LED_Point_out[6] | PIN_49 | LED7
LED_Point_out[7] | PIN_50 | LED8
LED_Point_out[8] | PIN_51 | LED9
LED_Point_out[9] | PIN_52 | LED10
LED_Point_out[10] | PIN_53 | LED11
LED_Point_out[11] | PIN_54 | LED12
LED_Point_out[12] | PIN_55 | LED13
LED_Point_out[13] | PIN_58 | LED14
LED_Point_out[14] | PIN_59 | LED15
LED_Point_out[15] | PIN_60 | LED16
LED_Time_out[0] | PIN_120 | G
LED_Time_out[1] | PIN_119 | F
LED_Time_out[2] | PIN_115 | E
LED_Time_out[3] | PIN_114 | D
LED_Time_out[4] | PIN_113 | C
LED_Time_out[5] | PIN_112 | B
LED_Time_out[6] | PIN_111 | A
dot | PIN_121 | DOT



