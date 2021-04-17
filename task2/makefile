all: exec

asm-libs: asm_task2Assignment1.s
	nasm -g -f elf -Wall -o asm_task2Assignment1.o asm_task2Assignment1.s
	
c-libs: main_task2Assignment1.c
	gcc -g -m32 -Wall -c -o main_task2Assignment1.o main_task2Assignment1.c

exec: asm-libs c-libs
	gcc -g -m32 -Wall -o exec main_task2Assignment1.o asm_task2Assignment1.o
	rm -f main_task2Assignment1.o asm_task2Assignment1.o
	
clean:
	rm -f *.o exec

