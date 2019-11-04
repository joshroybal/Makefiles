#!/bin/bash
set -v
# generate files and directories
mkdir $1
cd $1
mkdir src
touch src/$1.hpp
touch src/$1.cpp
touch src/main.cpp
mkdir obj
# generate skeletal source
# skeletal header
GUARD=$( echo "$1_H" | tr [a-z] [A-Z] )
echo $GUARD
echo "#ifndef $GUARD" >> src/$1.hpp
echo "#define $GUARD" >> src/$1.hpp
echo "#endif" >> src/$1.hpp
# skeletal function definition source file
echo "#include \"$1.hpp\"" >> src/$1.cpp
# skeletal main source file
echo "#include <iostream>" >> src/main.cpp
echo "#include \"$1.hpp\"" >> src/main.cpp
echo "" >> src/main.cpp
echo "int main()" >> src/main.cpp
echo "{" >> src/main.cpp
echo -e "\tstd::cout << \"under development\" << std::endl;" >> src/main.cpp
echo -e "\treturn 0;" >> src/main.cpp
echo -e "}" >> src/main.cpp
# generate Makefile
echo "CC = g++" > Makefile
echo "CFLAGS =" >> Makefile
echo "LFLAGS =" >> Makefile
echo "OBJS = obj/$1.o obj/main.o" >> Makefile
echo "BIN = $1" >> Makefile
echo "" >> Makefile
echo -e "$1: \$(OBJS)" >> Makefile
echo -e "\t\$(CC) \$^ -o \$@ \$(LFLAGS)" >> Makefile
echo "" >> Makefile
echo "obj/$1.o: src/$1.cpp src/$1.hpp" >> Makefile
echo -e "\t\$(CC) -c \$< \$(CFLAGS) -o \$@" >> Makefile
echo "" >> Makefile
echo "obj/main.o: src/main.cpp src/$1.hpp" >> Makefile
echo -e "\t\$(CC) -c \$< \$(CFLAGS) -o \$@" >> Makefile
echo "" >> Makefile
echo ".PHONY : clean" >> Makefile
echo "clean:" >> Makefile
echo -e "\t\$(RM) \$(OBJS)" >> Makefile
