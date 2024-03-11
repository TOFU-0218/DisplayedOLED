module Decorder_tb;

    reg i_clk = 1'b0;

    reg [20:0] i_instr;

    wire [3:0] o_dest; 
    wire [3:0] o_src;
    wire [7:0] o_imm;
    wire [7:0] o_addr;
    wire [2:0] o_alu_ctrl;
    wire o_rd_wen;
    wire [2:0] o_i2c_ctrl; 

    always #1 begin
        i_clk = ~i_clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, Decorder_tb);
    end

    Decorder Decorder_tb(
        .i_instr(i_instr),
        .o_dest(o_dest),
        .o_src(o_src),
        .o_imm(o_imm),
        .o_addr(o_addr),
        .o_alu_ctrl(o_alu_ctrl),
        .o_rd_wen(o_rd_wen),
        .o_i2c_ctrl(o_i2c_ctrl)
    );

    initial begin
        i_instr = 21'b000001010010100000000; // ADD
        #4
        i_instr = 21'b000101111111100000000; // SUB
        #4
        i_instr = 21'b001011111000011111110; // ADDI
        #4
        i_instr = 21'b001100000000000000000; // I2CSTART
        #4
        i_instr = 21'b010000000000000000000; // I2CSTOP
        #4
        i_instr = 21'b010101111111100000000; // LOAD
        #4
        i_instr = 21'b011000000111100000000; // SENDCON
        #4
        i_instr = 21'b011100000000000000000; // SENDI2C
        #4
        i_instr = 21'b100001111111100000000; // SETFLAG
        #4
        i_instr = 21'b100111111111101010101; // BEQ
        #4
        i_instr = 21'b101010000000011111111; // BEQF
        #4
        i_instr = 21'b101110000000010101010; // JMP
        #4
        i_instr = 21'b110000000000000000000; // NOP
        #4
        $finish;
    end



endmodule