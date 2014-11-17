#
# Simple makefile for file latency test program
#
# fs_mark.c is a modified version of Larry McVoy's lmbench program.
#
# Modifications include using fsync after wrting to flush to disk and changes to check return
# values from syscalls.
#
DIR1= /test/dir1
DIR2= /test/dir2

COBJS= fs_mark.o lib_timing.o
CFLAGS= -O2 -Wall -D_FILE_OFFSET_BITS=64

all: fs_mark 

fs_mark.o: fs_mark.c fs_mark.h

fs_mark: fs_mark.o lib_timing.o
	${CC} -o fs_mark fs_mark.o lib_timing.o

test: fs_mark
	./fs_mark -d ${DIR1} -d ${DIR2} -s 51200 -n 4096
	./fs_mark -d ${DIR1} -d ${DIR2} -s 51200 -n 4096 -r 
	./fs_mark -d ${DIR1} -d ${DIR2} -s 51200 -n 4096 -D 128
	./fs_mark -d ${DIR1} -d ${DIR2} -s 51200 -n 4096 -r -D 128

clean:
	rm -f ${COBJS} fs_mark fs_log.txt

