#include <stdio.h>

extern void assFunc(int); //import assembly function
extern char c_checkValidity(int);

char c_checkValidity(int x){
    if ((x % 2) == 0) return 1;
    else return 0;
}

int main (int argc, char** argv){
//read number from user
char input[50];
int number;
fgets(input, 50, stdin);
sscanf(input, "%d", &number);
assFunc(number);
return 0;
}
