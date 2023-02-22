#ifndef __MEMORY_VADDR_H__
#define __MEMORY_VADDR_H__

#include "common.h"



#define PAGE_SHIFT        12
#define PAGE_SIZE         (1ul << PAGE_SHIFT)
#define PAGE_MASK         (PAGE_SIZE - 1)

#endif
