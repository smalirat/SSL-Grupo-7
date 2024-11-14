export PATH="/c/msys64/usr/bin:$PATH"
export PATH="/c/msys64/mingw64/bin:$PATH"

bison -d -y calc.y
flex calc.l
gcc -c y.tab.h y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o $@ -lm