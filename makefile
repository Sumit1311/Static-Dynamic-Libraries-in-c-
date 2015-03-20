CC=g++
CFLAGS=-I./include
ARCHIVE = ar

SRC=./source
LIB=./lib
INC=./include
BIN=./bin
OBJ=./obj

all: $(BIN)/main.out

$(BIN)/main.out: $(LIB)/libsample.a $(OBJ)/main.o $(LIB)/libsampledynamic.so
	$(CC) -o $@ $(OBJ)/main.o -L./lib -lsample -lsampledynamic

$(LIB)/libsample.a: $(OBJ)/sample.o
	$(ARCHIVE) rcs $@ $(OBJ)/sample.o

$(OBJ)/sample.o: $(SRC)/sample.cpp
	$(CC) -o $@ -c $<

$(OBJ)/main.o: $(INC)/libsample.h main.cpp
	$(CC) -o $@ -c main.cpp $(CFLAGS)

$(LIB)/libsampledynamic.so: $(SRC)/sampleDynamic.cpp
	gcc -c -fpic $< -o $(OBJ)/libsampledynamic.o
	gcc -shared -o $@ $(OBJ)/libsampledynamic.o

clean: 
	rm -rf ./obj/*.o
	rm -rf ./bin/*