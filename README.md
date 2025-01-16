# Cybersec

This repo contains some examples of buffer overflows on the stack. Note: While these exploits "work", we have to disable
pretty much any security feature modern compilers offer and for the second one even OS security features (namely ASLR).
This does not mean buffer overflows are no longer an issue, rather that they are usually way more advanced to exploit.

## local_buffer.c

Simple buffer overflow with two buffers on the stack. The first buffer contains the hardcoded "password" `secret1`, the
second one is populated by user input using the insecure `gets()` function. The two buffers are compared and if the
contents match (i.e. the user inputs the correct password), "access" is granted. Without knowledge of the "secret", we
can still gain access, abusing `gets()`. Both buffers are 8 bytes long, so any input that exceeds this size will
overflow the second buffer. Due to the memory layout of the program, the 9th until the 16th byte will override the firt
buffer, thus the secret that is compared to the user input. By inputting the same 8 byte long value repeatedly, we
achieve matching contents for both buffers, which results in gaining access without the actual password. An example for
this is the input `1234567812345678` so that each buffer contains `12345678` afterward and thus bypasses authentication.

