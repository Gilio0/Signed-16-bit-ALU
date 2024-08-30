vlib work
vlog ALU_TB.v ALU_TOP.v ARITHMETIC_UNIT.v CMP_UNIT.v Decoder_UNIT.v LOGIC_UNIT.v SHIFT_UNIT.v
vsim -voptargs=+accs work.ALU_TB
add wave -position insertpoint  \
sim:/ALU_TB/DUT_ALU_TOP/IN_DATA_WIDTH \
sim:/ALU_TB/DUT_ALU_TOP/ARITH_OUT_WIDTH \
sim:/ALU_TB/DUT_ALU_TOP/LOGIC_OUT_WIDTH \
sim:/ALU_TB/DUT_ALU_TOP/SHIFT_OUT_WIDTH \
sim:/ALU_TB/DUT_ALU_TOP/CMP_OUT_WIDTH \
sim:/ALU_TB/DUT_ALU_TOP/A \
sim:/ALU_TB/DUT_ALU_TOP/B \
sim:/ALU_TB/DUT_ALU_TOP/CLK \
sim:/ALU_TB/DUT_ALU_TOP/RST \
sim:/ALU_TB/DUT_ALU_TOP/ALU_FUN \
sim:/ALU_TB/DUT_ALU_TOP/SHIFT_OUT \
sim:/ALU_TB/DUT_ALU_TOP/Arith_OUT \
sim:/ALU_TB/DUT_ALU_TOP/Logic_OUT \
sim:/ALU_TB/DUT_ALU_TOP/CMP_OUT \
sim:/ALU_TB/DUT_ALU_TOP/SHIFT_Flag \
sim:/ALU_TB/DUT_ALU_TOP/CMP_Flag \
sim:/ALU_TB/DUT_ALU_TOP/Arith_Flag \
sim:/ALU_TB/DUT_ALU_TOP/Logic_Flag \
sim:/ALU_TB/DUT_ALU_TOP/Arith_Enable \
sim:/ALU_TB/DUT_ALU_TOP/Logic_Enable \
sim:/ALU_TB/DUT_ALU_TOP/CMP_Enable \
sim:/ALU_TB/DUT_ALU_TOP/Shift_Enable
run -all