/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <isa.h>
#include "local-include/reg.h"

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

void isa_reg_display() {
	int i;
	const char *temp = NULL;
	for(i = 0; i < 32; i++)
	{
		temp = regs[i];
		printf("reg %s ,value = %ld\n", temp, cpu.gpr[i]);
	}

}

word_t isa_reg_str2val(const char *s, bool *success) {
  int i = 0;
  int j = 0;
  printf("%s", s);
  while((strcmp(s,regs[i])) == -1)
  {
	i++;
	j = i;
  }
  printf("j = %d\n", j);
  word_t reg_value = cpu.gpr[j];	 
  return reg_value;
}
