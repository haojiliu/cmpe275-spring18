CXX = gcc-7
CFLAGS=-Wall -mavx2 -mfma -O1 -std=c99 -fopenmp
CFILES= main.c header.h utils.c optimizations.c
all:
	$(CXX) $(CFLAGS) $(CFILES) -lm -o main
clean:
	rm main
	rm -f *.o
	rm -f *.s
assembly:
	$(CXX) $(CFLAGS) -c main.c -S -o main.s
	$(CXX) $(CFLAGS) -c utils.c -S -o utils.s
	$(CXX) $(CFLAGS) -c optimizations.c -S -o optimizations.s
