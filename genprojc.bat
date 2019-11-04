@echo off
REM generate files and directories
mkdir %1
cd %1
mkdir src
REM generate skeletal source files
type nul > src\%1.h
type nul > src\%1.c
type nul > src\main.c
echo #ifndef %1_H >> src\%1.h
echo #define %1_H >> src\%1.h
echo #endif >> src\%1.h
echo #include "%1.h" >> src\%1.c
echo #include ^<iostream^> >> src\main.c
echo #include "%1.h" >> src\main.c
echo. >> src\main.c
echo int main() >> src\main.c
echo { >> src\main.c
echo 	std::cout ^<^< "under development" ^<^< std::endl; >> src\main.c
echo } >> src\main.c
mkdir obj
REM generate Makefile
echo CC = cl > Makefile
echo CFLAGS = /O2 /Za >> Makefile
echo LFLAGS = >> Makefile
echo OBJS = obj\%1.obj obj\main.obj >> Makefile
echo BIN = %1.exe >> Makefile
echo. >> Makefile
echo $(BIN): $(OBJS) >> Makefile
echo 	$(CC) /Fe$@ $(OBJS) $(LFLAGS) >> Makefile
echo. >> Makefile
echo obj/%1.obj: src/%1.c src/%1.h >> Makefile
echo 	$(CC) /Fo$@ /c src\%1.c $(CFLAGS) >> Makefile
echo. >> Makefile
echo obj/main.obj: src/main.c src/%1.h >> Makefile
echo 	$(CC) /Fo$@ /c src\main.c $(CFLAGS) >> Makefile
echo. >> Makefile
echo .PHONY : clean >> Makefile
echo clean: >> Makefile
echo 	$(RM) $(OBJS) >> Makefile
nmake
