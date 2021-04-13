all: exec

asm-libs: asmTask1.s
	nasm -g -f elf -Wall -o asmTask1.o asmTask1.s
	
c-libs: task1.c
	gcc -g -m32 -Wall -c -o task1.o task1.c

exec: asm-libs c-libs
	gcc -g -m32 -Wall -o exec task1.o asmTask1.o
	rm -f task1.o asmTask1.o
	
clean:
	rm -f *.o exec

