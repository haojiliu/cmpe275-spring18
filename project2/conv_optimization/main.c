/*
 ============================================================================
 Name        : main.c
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


	uint64_t* results[NUM_OF_OPTIMIZATIONS] = {}; /* Store the outputs of optimizations */
	uint64_t* references[NUM_OF_OPTIMIZATIONS] = {};
	double  times[NUM_OF_OPTIMIZATIONS] = {}; /* Store the time measurement of optimizations */
	int  errors[NUM_OF_OPTIMIZATIONS] = {}; /* Store whether the optimization has the correct result */

	void (*functions[NUM_OF_OPTIMIZATIONS])(uint64_t*, const uint16_t*, const uint16_t*) ={ /* The optimization functions */
		 naive,
		 openmp,
		 simd,
		 loopUnroll,
		 openmp_simd,
		 openmp_simd_loopUnroll};

	const char*   names[NUM_OF_OPTIMIZATIONS] ={ /* optimization names */
		 "naive",
		 "openmp",
		 "simd",
		 "loop unroll",
		 "openmp & simd",
		 "openmp & simd & loop unroll"};

	const int enables[NUM_OF_OPTIMIZATIONS] = { /* whether or not enable the test of some optimizations */
		 ENABLE,ENABLE,ENABLE, ENABLE, ENABLE, ENABLE};

  // const int enables[NUM_OF_OPTIMIZATIONS] = { /* whether or not enable the test of some optimizations */
  // 	 0,1,0,0,0,0,0,0,0};

	/* Do multiple experiments. Measure the average runtime. */
	const int NUM_OF_EXPERIMENTS = 20;

  // init two matrices
  uint16_t * matrix1 = _mm_malloc(WIDTH1*HEIGHT1*sizeof(uint16_t), 64);
  uint16_t * matrix2 = _mm_malloc((WIDTH2*HEIGHT2+2*PAD)*sizeof(uint16_t), 64);
  for (int i = 0; i < PAD; i++) {
    matrix2[i] = 0;
  }
  matrix2 += PAD;
  for (int k = 0; k < WIDTH1*HEIGHT1; k++) {
      matrix1[k] = rand()%65535;
  }
  for (int k = 0; k < WIDTH2*HEIGHT2; k++) {
    matrix2[k] = rand()%65535;
  }

	for (int i = 0; i < NUM_OF_EXPERIMENTS; i++) {
		for (int j = 0; j < NUM_OF_OPTIMIZATIONS; j++) {
			if (enables[j]) {
				results[j] = _mm_malloc(WIDTH2*HEIGHT2*sizeof(uint64_t), 64);
				references[j] = _mm_malloc(WIDTH2*HEIGHT2*sizeof(uint64_t), 64);
				uint64_t start = timestamp_us();
				functions[j](results[j], matrix1, matrix2);
				times[j] += (timestamp_us() - start);
				if (i == 0) {
					naive(references[j], matrix1, matrix2);
					errors[j] = compare_matrix(results[j], references[j]);
				}
				_mm_free(results[j]);
				_mm_free(references[j]);
			}
		}
	}

  // free two matrices
  _mm_free(matrix1);
  _mm_free(matrix2-PAD);

	for (int i = 0; i < NUM_OF_OPTIMIZATIONS; i++) {
		/* Output time measurement results */
		if (enables[i]) {
			if (!enables[0])
				printf("%-65s:%.3f\n", names[i], times[i] / 1000000L / NUM_OF_EXPERIMENTS);
			else
				printf("%-65s:%.3f speedup: %.4f\n", names[i],  times[i] / 1000000L / NUM_OF_EXPERIMENTS, times[0]/times[i]);
		}

		/* Error Handling */
		if (errors[i]) {
			printf ("The result of %s is wrong\n", names[i]);
		}
	}

	return 0;
}
