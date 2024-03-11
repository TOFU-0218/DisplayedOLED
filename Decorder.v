module Decorder(
    input wire [20:0] i_instr, // 命令入力
    output wire [3:0] o_dest, // 目的地レジスタorフラグ指定
    output wire [3:0] o_src, // ソースレジスタorフラグ指定
    output wire [7:0] o_imm, // 即値
    output wire [7:0] o_addr, // メモリアドレス
    output wire [2:0] o_alu_ctrl, // ALU命令
    output wire o_rd_wen, // レジスタ書き込み有効化信号
    output wire o_i2c_ctrl // i2cコントローラー制御信号
);

// 命令分解
// [20:16] 命令コード
// [15:12] destraction設定
// [11:8] source指定
// [7:0] 即値
assign [4:0] o_alu_ctrl = alu_ctrl(i_instr[20:16]); // ALU命令
assign [3:0] o_dest = i_instr[19:16]; // 目的地レジスタorフラグ指定
assign [3:0] o_src = i_instr[15:12]; // ソースレジスタorフラグ指定
assign [7:0] o_imm = imm(i_instr); // 即値
assign [7:0] o_addr = addr(i_instr); // メモリアドレス
assign o_rs_wen = rs_wen(i_instr[20:16]); // レジスタ書き込み有効化信号

// ALU命令
function [2:0] alu_ctrl(
    input [4:0] w_opcode
    );
    case(w_opcode)
        5'b00000 : alu_ctrl = 3'b001; // ADD
        5'b00010 : alu_ctrl = 3'b010; // SUB
        5'b00101 : alu_ctrl = 3'b001; // ADDI
        5'b10011 : alu_ctrl = 3'b011; // BEQ
        5'b10101 : alu_ctrl = 3'b100; // BEQF
        default : alu_ctrl = 3'b000; // NOP
    endcase
endfunction



endmodule

