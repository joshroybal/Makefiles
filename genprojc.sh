#!/bin/bash
set -v
# generate files and directories
mkdir $1
cd $1
mkdir src
#touch src/$1.h
#touch src/$1.c
#touch src/main.c
mkdir obj
# generate skeletal source
# skeletal header
GUARD=$( echo "$1_H" | tr [a-z] [A-Z] )
echo $GUARD
echo "#ifndef $GUARD" > src/$1.h
echo "#define $GUARD" >> src/$1.h
echo "#endif" >> src/$1.h
# skeletal function definition source file
echo "#include \"$1.h\"" > src/$1.c
# skeletal main source file
echo "#include <stdio.h>" > src/main.c
echo "#include \"$1.h\"" >> src/main.c
echo "" >> src/main.c
echo "int main()" >> src/main.c
echo "{" >> src/main.c
echo -e "\tprintf(\"under development\\\n\");" >> src/main.c
echo -e "\treturn(0);" >> src/main.c
echo -e "}" >> src/main.c
# generate Makefile
echo "CC = gcc" > Makefile
echo "CFLAGS =" >> Makefile
echo "LFLAGS =" >> Makefile
echo "OBJS = obj/$1.o obj/main.o" >> Makefile
echo "HDRS = src/$1.h" >> Makefile
echo "BIN = $1" >> Makefile
echo "" >> Makefile
echo "obj/%.o: src/%.c \$(HDRS)" >> Makefile
echo -e "\t\$(CC) -c \$< \$(CFLAGS) -o \$@" >> Makefile
echo "">> Makefile
echo -e "\$(BIN): \$(OBJS)" >> Makefile
echo -e "\t\$(CC) \$^ -o \$@ \$(LFLAGS)" >> Makefile
echo "" >> Makefile
echo ".PHONY : clean" >> Makefile
echo "clean:" >> Makefile
echo -e "\t\$(RM) \$(OBJS)" >> Makefile
