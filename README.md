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

## nop_sled.c

More advanced overflow with a single buffer on the stack, in another function. The overflow is again cause by the
insecure function `gets()`. This time however we don't overwrite an adjacent buffer, but rather the metadata on the
stack. We try to overwrite the stored address of the instruction that is supposed to be run next after the function
returns. The new address we put there is somewhere at the beginning of our buffer. We start by filling our buffer with
NOP instructions following the actual shell code (actual code we want to run; usually starting a shell, hence the name)
and finally the already mentioned address. If we mange to layout everything like that, the function should on return not
jump back to `main()` but somewhere close to the beginning of our buffer. If we are close enough some NOP's are
executed (which allow us some margin for error with the address; hence this is called a NOP sled), followed by the
shellcode. This will use the syscall `execve` to replace our current process with an instance of `/bin/sh`.
