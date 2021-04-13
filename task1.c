#include <stdio.h>

extern void assFunc(int); //import assembly function
extern char c_checkValidity(int);

char c_checkValidity(int x){
    if ((x % 2) == 0) return 1;
    else return 0;
}

int main (char argc, char** argv){
//read number from user
char input;
int number;
while(1){
    printf("Please insert a number:\n");
    fgets(input, 50, stdin);
    sscanf(input, "%d", &number);
    assFunc(number);
}

return 0;
}
