#define _GNU_SOURCE

#include "main.h"
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define BUFFER_SIZE 8

bool authenticate(uint8_t* user_pwd, uint8_t* shadow_pwd)
{
  return strncmp(user_pwd, shadow_pwd, BUFFER_SIZE) == 0;
}

int main(void)
{
  uint8_t shadow_pwd[BUFFER_SIZE] = "secret1";
  uint8_t user_pwd[BUFFER_SIZE];

  printf("Enter password to access system: ");
  gets(&user_pwd);

  bool is_permitted = authenticate(&user_pwd[0], &shadow_pwd[0]);
  if (is_permitted)
    printf("Successfully authenticated\n");
  else
    printf("Authentication failed\n");

  return 0;
}
