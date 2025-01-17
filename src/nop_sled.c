#define _GNU_SOURCE

#include <stdint.h>
#include <stdio.h>

void foo()
{
  uint8_t buffer[64];
  printf("buffer address: %p\n", buffer);
  gets(&buffer);
}

int main(void)
{
  foo();
  fprintf(stdout, "Very foo, mister bar!\n");
  return 0;
}
