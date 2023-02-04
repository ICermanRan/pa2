######################################################################
# author:ran
# 学号：ysyx_220578
######################################################################

# 1.files info:
CSRC +=  $(shell find $(abspath ./csrc) -name "*.cpp")
VSRC +=  $(shell find $(abspath ./vsrc) -name "*.v" -or -name "*.sv")
TOP_MODULE := ysyx_22050078_npc
SEARCHPATH := ./vsrc


# 2.verilator flags:
#--trace:输出目标被构建的原因和执行的命令.
VERILATOR_FLAGS += -Wall --trace --cc --exe --build
VERILATOR_FLAGS += -I${SEARCHPATH}
VERILATOR_FLAGS += --top ${TOP_MODULE}
VERILATOR_FLAGS += -Wno-UNUSED
VERILATOR_FLAGS += -Wno-UNDRIVEN
VERILATOR_FLAGS += -Wno-INCABSPATH
GCC_LDFLAGS := -LDFLAGS -ldl

# 3.run info:
OBJ_DIR := ./obj_dir
BIN := ${OBJ_DIR}/V${TOP_MODULE}
IMG ?= ../am-kernels/tests/cpu-tests/build/dummy-riscv64-npc.bin
DIFFTEST := ${NEMU_HOME}/build/riscv64-nemu-interpreter-so
RUN_FLAGS := --img=${IMG} --diff=${DIFFTEST}

.PHONY:sim wave clean


# Set up variables
# VERILATOR =verilator
# # Generate C++ in executable form
# VERILATOR_FLAGS += -cc --exe
# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_FLAGS += -MMD
# Optimize
# Warn abount lint issues; may not want this on less solid designs
# VERILATOR_FLAGS += -Wall
# # Make waveforms
# VERILATOR_FLAGS += --trace
# # Check SystemVerilog assertions
# #VERILATOR_FLAGS += --assert
# # Generate coverage analysis
# # Run Verilator in debug mode
# # VERILATOR_FLAGS += --debug
# # Add this trace to get a backtrace in gdb
# #VERILATOR_FLAGS += --gdb
# VERILATOR_FLAGS += --build
# # 关闭 警告 unused INCABSPATH
# VERILATOR_FLAGS += -Wno-UNUSED 
# VERILATOR_FLAGS += -Wno-PINCONNECTEMPTY
# VERILATOR_FLAGS += -Wno-UNDRIVEN
# VERILATOR_FLAGS += -Wno-INCABSPATH
# #包含的头文件
# VERILATOR_FLAGS += -I./vsrc  -y ./vsrc 
# VERILATOR_FLAGS += --top-module ysyx_22050078_npc_onecycle

# Input files for Verilator    包括 c 与  v
# VERILATOR_INPUT +=  ./vsrc/ysyx_22050078_npc_onecycle
# VERILATOR_INPUT +=	./vsrc/ysyx_22050078_register.v  ./vsrc/ysyx_22050078_pc_reg.v ./vsrc/ysyx_22050078_IFU.v ./vsrc/ysyx_22050078_IDU.v ./vsrc/ysyx_22050078_EXU.v ./vsrc/defines.v
# VERILATOR_INPUT +=  ./csrc/npc.cpp 


com:$(CSRC) $(VSRC)
	@verilator ${VERILATOR_FLAGS} ${CSRC} ${VSRC} ${GCC_LDFLAGS}

run:com
	@${BIN} ${RUN_FLAGS}
	#$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!	
###################################################
	
wave:
# ./obj_dir/Vysyx_22050078_npc_onecycle
	gtkwave waveform.vcd

clean:
	rm -rf ${OBJ_DIR}
	rm waveform.vcd

include ../Makefile