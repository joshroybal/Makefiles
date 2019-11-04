@echo off
REM generate files and directories
mkdir %1
cd %1
mkdir src
REM generate skeletal source files
type nul > src\%1.hpp
type nul > src\%1.cpp
type nul > src\main.cpp
echo #ifndef %1_H >> src\%1.hpp
echo #define %1_H >> src\%1.hpp
echo #endif >> src\%1.hpp
echo #include "%1.hpp" >> src\%1.cpp
echo #include ^<iostream^> >> src\main.cpp
echo #include "%1.hpp" >> src\main.cpp
echo. >> src\main.cpp
echo int main() >> src\main.cpp
echo { >> src\main.cpp
echo 	std::cout ^<^< "under development" ^<^< std::endl; >> src\main.cpp
echo } >> src\main.cpp
mkdir obj
REM generate Makefile
echo CC = cl > Makefile
echo CFLAGS = /EHsc /O2 >> Makefile
echo LFLAGS = >> Makefile
echo OBJS = obj\%1.obj obj\main.obj >> Makefile
echo BIN = %1.exe >> Makefile
echo. >> Makefile
echo $(BIN): $(OBJS) >> Makefile
echo 	$(CC) /Fe$@ $(OBJS) $(LFLAGS) >> Makefile
echo. >> Makefile
echo obj/%1.obj: src/%1.cpp src/%1.hpp >> Makefile
echo 	$(CC) /Fo$@ /c src\%1.cpp $(CFLAGS) >> Makefile
echo. >> Makefile
echo obj/main.obj: src/main.cpp src/%1.hpp >> Makefile
echo 	$(CC) /Fo$@ /c src\main.cpp $(CFLAGS) >> Makefile
echo. >> Makefile
echo .PHONY : clean >> Makefile
echo clean: >> Makefile
echo 	$(RM) $(OBJS) >> Makefile
nmake
