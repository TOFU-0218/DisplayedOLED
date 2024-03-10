module Decorder(
    input wire [20:0] i_instr, // 命令入力
    output wire [3:0] o_dest, // 目的地レジスタorフラグ指定
    output wire [3:0] o_src, // ソースレジスタorフラグ指定
    output wire [7:0] o_imm, // 即値
    output wire [7:0] o_addr, // メモリアドレス
    output wire [2:0] o_opcode, // ALU命令
    output wire o_rs_wen, // レジスタ書き込み有効化信号
    output wire o_flg_wen, // レジスタ書き込み有効化信号
    output wire o_i2c_start, // I2C通信開始信号
    output wire o_i2c_stop, // I2C通信終了信号
    output wire o_sendcon, // コントローラへの送信信号
    output wire o_sendi2c, // i2c経由経由でのデータ送信信号
);

// 命令分解
// [20:16] 命令コード
// [15:12] destraction設定
// [11:8] source指定
// [7:0] 即値
assign [4:0] o_opcode = opcode(i_instr[20:16]);
assign [3:0] w_dest = i_instr[19:16];
assign [3:0] w_src = i_instr[15:12];
assign [7:0] w_imm = i_instr[7:0];

// ALU命令
function [2:0] opcode(
    input [4:0] w_opcode
    );
    case(w_opcode)
        5'b00000 : opcode = 3'b001; // ADD
        5'b00010 : opcode = 3'b010; // SUB
        5'b00101 : opcode = 3'b001; // ADDI
        5'b10011 : opcode = 3'b011; // BEQ
        5'b10101 : opcode = 3'b100; // BEQF
        default : opcode = 3'b000; // NOP
    endcase
endfunction

// I2C通信関連
assign o_i2c_start = (w_opcode == 5'b00110) ? 1'b1 : 1'b0; // I2CSTART
assign o_i2c_stop = (w_opcode == 5'b01000) ? 1'b1 : 1'b0; // I2CSTOP

// メモリ関連
if (w_opcode == 5'b01010) begin
    assign o_addr = w_src;
    assign o_dest = w_dest;
end

// コントローラ制御信号関連
if (w_opcode == 5'b)


endmodule

