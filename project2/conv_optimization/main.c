/*
 ============================================================================
 Name        : main.c
 Author      : Jason Su and Harry He
 Version     : 1.0.0
 Copyright   : GNU
 Description : 7*7 1024*1024 2-D non-separable convolution
 ============================================================================
 */
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include <time.h>
#include <immintrin.h>
#include <xmmintrin.h>

#include "header.h"

/* Return the current system time in micro seconds */
static inline uint64_t timestamp_us()
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return 1000000L * tv.tv_sec + tv.tv_usec;
}

int main(int argc, char *argv[])
{
	srand (time(NULL));
	omp_set_num_threads(8);

	uint16_t* matrix1s[NUM_OF_OPTIMIZATIONS] = {};
	uint16_t* matrix2s[NUM_OF_OPTIMIZATIONS] = {};
	uint64_t* results[NUM_OF_OPTIMIZATIONS] = {}; /* Store the outputs of optimizations */
	uint64_t* references[NUM_OF_OPTIMIZATIONS] = {};
	double  times[NUM_OF_OPTIMIZATIONS] = {}; /* Store the time measurement of optimizations */
	int  errors[NUM_OF_OPTIMIZATIONS] = {}; /* Store whether the optimization has the correct result */

	void (*functions[NUM_OF_OPTIMIZATIONS])(uint64_t*, const uint16_t*, const uint16_t*) ={ /* The optimization functions */
		 naive,
		 openmp,
		 simd,
		 cacheBlock,
		 loopUnroll,
		 registerBlock,
		 openmp_simd,
		 openmp_simd_loopUnroll,
		 openmp_simd_loopUnroll_registerBlock};

	const char*   names[NUM_OF_OPTIMIZATIONS] ={ /* optimization names */
		 "naive",
		 "openmp",
		 "simd",
		 "cache block",
		 "loop unroll",
		 "register block",
		 "openmp & simd",
		 "openmp & simd & loop unroll",
		 "openmp & simd & loop unroll & register block"};

	const int enables[NUM_OF_OPTIMIZATIONS] = { /* whether or not enable the test of some optimizations */
		 ENABLE,ENABLE,ENABLE, ENABLE, ENABLE, ENABLE, ENABLE, ENABLE, ENABLE};
		 /*
		 ENABLE,
		 ENABLE,
		 ENABLE,
		 ENABLE,
		 ENABLE,
	     ENABLE,
		 ENABLE,
		 ENABLE,
		 ENABLE};*/

	/* Do multiple experiments. Measure the average runtime. */
	const int NUM_OF_EXPERIMENTS = 50;

	for (int i = 0; i < NUM_OF_EXPERIMENTS; i++) {

		for (int j = 0; j < NUM_OF_OPTIMIZATIONS; j++) {
			if (enables[j]) {
				matrix1s[j] = _mm_malloc(WIDTH1*HEIGHT1*sizeof(uint16_t), 64);
				matrix2s[j] = _mm_malloc((WIDTH2*HEIGHT2+2*PAD)*sizeof(uint16_t), 64);
				for (int i = 0; i < PAD; i++) {
					matrix2s[j][i] = 0;
				}
				matrix2s[j] += PAD;
				for (int k = 0; k < WIDTH1*HEIGHT1; k++) {
						matrix1s[j][k] = rand()%65535;
				}

				for (int k = 0; k < WIDTH2*HEIGHT2; k++) {
					matrix2s[j][k] = rand()%65535;
				}
				results[j] = _mm_malloc(WIDTH2*HEIGHT2*sizeof(uint64_t), 64);
				references[j] = _mm_malloc(WIDTH2*HEIGHT2*sizeof(uint64_t), 64);
				uint64_t start = timestamp_us();
				functions[j](results[j], matrix1s[j], matrix2s[j]);
				times[j] += (timestamp_us() - start) / 1000000.0 / NUM_OF_EXPERIMENTS;
				if (i == 0) {
					naive(references[j], matrix1s[j], matrix2s[j]);
					errors[j] = compare_matrix(results[j], references[j]);
				}
				_mm_free(matrix1s[j]);
				_mm_free(matrix2s[j]-PAD);
				_mm_free(results[j]);
				_mm_free(references[j]);
			}
		}
	}

	for (int i = 0; i < NUM_OF_OPTIMIZATIONS; i++) {
		/* Output time measurement results */
		if (enables[i]) {
			if (!enables[0])
				printf("%-65s:%.3f\n", names[i], times[i]);
			else
				printf("%-65s:%.3f speedup: %.4f\n", names[i], times[i], times[0]/times[i]);
		}

		/* Error Handling */
		if (errors[i]) {
			printf ("The result of %s is wrong\n", names[i]);
		}
	}

	return 0;
}
