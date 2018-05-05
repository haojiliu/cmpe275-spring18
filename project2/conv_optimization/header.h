#ifndef MATRIX_HEADER
#define MATRIX_HEADER

#include <string.h>
#include <immintrin.h>
#include <stdint.h>

#define ENABLE 1
#define DISABLE 0

#define PAD (8*1024)

#define WIDTH1 7
#define HEIGHT1 7

#define WIDTH2 1024
#define HEIGHT2 1024

#define LINE_SIZE 64
#define L1_SIZE (32*1024)
#define L2_SIZE (256*1024)
#define L3_SIZE (6144*1024)
#define L4_SIZE (131072*1024)

#define NUM_OF_OPTIMIZATIONS 9


extern int compare_matrix(const uint64_t* sample, const uint64_t* reference);

extern void naive(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void openmp(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void simd(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void cacheBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void loopUnroll(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void registerBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void openmp_simd(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void openmp_simd_loopUnroll(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

extern void openmp_simd_loopUnroll_registerBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2);

#endif
