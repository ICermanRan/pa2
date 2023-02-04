`include "/home/ran/ysyx/ysyx-workbench/npc/vsrc/defines.v"

module ysyx_22050078_npc 
#(parameter ADDR_WIDTH = 5, 
            DATA_WIDTH = 64, 
            INST_WIDTH = 32, 
            INSTADDR_WIDTH = 64, 
            PC_WIDTH = 64)
(
    input clk,
    input rst,
    input [INST_WIDTH - 1:0] inst,
    output [PC_WIDTH - 1:0] inst_addr_cpu2mem
);

//1.rst: /////////////////////////////////////////////////
    wire rst_n_sync;


//2.cpu: /////////////////////////////////////////////////
    //pc to IFU
    wire [PC_WIDTH - 1:0] pc_reg2_IFU;

    //IFU to inst_memory
    //import "DPI-C" function void pmem_read(input longint raddr);


    //IFU to IDU
    wire [INST_WIDTH - 1:0] inst_IFU2IDU;
    wire [INSTADDR_WIDTH - 1:0] pc_IFU2IDU;

    //IDU to regs
    wire [4:0] rs1_addr_IDU2regs;
    wire [4:0] rs2_addr_IDU2regs;

    //regs to IDU
    wire [DATA_WIDTH - 1:0] src1_regs2IDU;
    wire [DATA_WIDTH - 1:0] src2_regs2IDU;

    //IDU to EXU
    wire [INST_WIDTH - 1:0] inst_IDU2EXU;
    wire [6:0] opcode_IDU2EXU;
    wire [4:0] rd_addr_IDU2EXU;
    wire [DATA_WIDTH - 1:0] op1_IDU2EXU;
    wire [DATA_WIDTH - 1:0] op2_IDU2EXU;
    wire [2:0] func3_IDU2EXU;
    wire [6:0] func7_IDU2EXU;

    //EXU to regs
    wire [4:0] rd_addr_EXU2regs;
    wire [DATA_WIDTH - 1:0] rd_data_EXU2regs;
    wire rd_wen_EXU2regs;

    ysyx_22050078_pc_reg ysyx_22050078_pc_reg_inst(
        .clk(clk),
        .rst(rst),
        .pc(pc_reg2_IFU)
    );

    ysyx_22050078_IFU ysyx_22050078_IFU_inst(
        .pc(pc_reg2_IFU),               //pc_reg to IFU     
        .inst_in(inst),                 //memory to IFU
        .inst_out(inst_IFU2IDU),
        .pc_IFU2IDU(pc_IFU2IDU),
        .pc_IFU2mem(inst_addr_cpu2mem)   //IFU to memory
    );

    ysyx_22050078_IDU ysyx_22050078_IDU_inst(
        .inst_in(inst_IFU2IDU),
        .pc_in(pc_IFU2IDU),
        .src1_in(src1_regs2IDU),
        .src2_in(src2_regs2IDU),
        .rs1_addr(rs1_addr_IDU2regs),
        .rs2_addr(rs2_addr_IDU2regs),
        .inst_out(inst_IDU2EXU),
        .opcode(opcode_IDU2EXU),
        .rd_addr(rd_addr_IDU2EXU),
        .op1(op1_IDU2EXU),
        .op2(op2_IDU2EXU),
        .func3(func3_IDU2EXU),
        .func7(func7_IDU2EXU)
    );

    ysyx_22050078_EXU ysyx_22050078_EXU_inst(
        .inst_in(inst_IDU2EXU),
        .opcode(opcode_IDU2EXU),
        .rd_addr_in(rd_addr_IDU2EXU),
        .op1(op1_IDU2EXU),
        .op2(op2_IDU2EXU),
        .func3(func3_IDU2EXU),
        .func7(func7_IDU2EXU),
        .rd_addr_out(rd_addr_EXU2regs),
        .rd_data_out(rd_data_EXU2regs),
        .rd_wen(rd_wen_EXU2regs) 
    );

    ysyx_22050078_register ysyx_22050078_register_inst( 
        .clk(clk),
        .w_en(rd_wen_EXU2regs),
        .rs1_addr(rs1_addr_IDU2regs),
        .rs2_addr(rs2_addr_IDU2regs),
        .rd(5'd0),
        .wr_data(rd_data_EXU2regs),
        .wr_addr(rd_addr_EXU2regs),
        .rd_data1(src1_regs2IDU),
        .rd_data2(src2_regs2IDU)
    );

  //3.sim:  ////////////////////////////////////////////////////////
  import "DPI-C" function void check_rst(input bit rst_flag);
  import "DPI-C" function bit check_finish(input int finish_flag);
  always @(*) 
   begin
    check_rst(rst_n_sync);  
    // if(check_finish(ins)) 
    //  begin
    //   $display("\n----------EBREAK: HIT !!%s!! TRAP!!---------------\n",a0zero? "GOOD":"BAD");
    //   $finish;
    //  end
    // if(rst_n_sync &)
   end

endmodule