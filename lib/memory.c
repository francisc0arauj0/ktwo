#include "memory.h"
#include "stdint.h"

void *memset(void *ptr, int value, size_t number) {
	unsigned char *p = ptr;
	while (number--) {
		*p++ = (unsigned char)value;
	}
	return ptr;
}