#include "header.h"

void naive(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {
	memset(result, 0, WIDTH*HEIGHT*sizeof(double));
	for (int i = 0; i < WIDTH; i++)
	{
		for (int k = 0; k < WIDTH; k++)
		{
			double t = matrix1[i*WIDTH+k];
			for (int j = 0; j < HEIGHT; j++)
			{
				result[i*WIDTH+j] += t*matrix2[k*WIDTH+j];
			}
		}
	}
}

void openmp(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {
	memset(result, 0, WIDTH*HEIGHT*sizeof(double));
	#pragma omp parallel for
	for (int i = 0; i < WIDTH; i++)
	{
		for (int k = 0; k < WIDTH; k++)
		{
			double t = matrix1[i*WIDTH+k];
			for (int j = 0; j < HEIGHT; j++)
			{
				result[i*WIDTH+j] += t*matrix2[k*WIDTH+j];
			}
		}
	}
}

void simd(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {
	memset(result, 0, WIDTH*HEIGHT*sizeof(double));
	for (int i = 0; i < WIDTH; i++)
	{
		for (int k = 0; k < WIDTH; k++)
		{
			__m256d t = _mm256_broadcast_sd(matrix1+i*WIDTH+k);
			for (int j = 0; j < HEIGHT; j+=4)
			{
				__m256d r = _mm256_load_pd(result+i*WIDTH+j);
				r = _mm256_fmadd_pd(_mm256_load_pd(matrix2+k*WIDTH+j), t, r);
				_mm256_store_pd(result+i*WIDTH+j, r);
			}
		}
	}
}

void loopUnroll(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {
	memset(result, 0, WIDTH*HEIGHT*sizeof(double));
	for (int i = 0; i < WIDTH; i++)
	{
		double* dest = result + i*WIDTH;
		for (int k = 0; k < WIDTH; k++)
		{
			double t = matrix1[i*WIDTH+k];
			const double* mat2 = matrix2+k*WIDTH;
			for (int j = 0; j < HEIGHT; j+=32)
			{
				dest[j] += t*mat2[j];
				dest[j+1] += t*mat2[j+1];
				dest[j+2] += t*mat2[j+2];
				dest[j+3] += t*mat2[j+3];
				dest[j+4] += t*mat2[j+4];
				dest[j+5] += t*mat2[j+5];
				dest[j+6] += t*mat2[j+6];
				dest[j+7] += t*mat2[j+7];
				dest[j+8] += t*mat2[j+8];
				dest[j+9] += t*mat2[j+9];
				dest[j+10] += t*mat2[j+10];
				dest[j+11] += t*mat2[j+11];
				dest[j+12] += t*mat2[j+12];
				dest[j+13] += t*mat2[j+13];
				dest[j+14] += t*mat2[j+14];
				dest[j+15] += t*mat2[j+15];
				dest[j+16] += t*mat2[j+16];
				dest[j+17] += t*mat2[j+17];
				dest[j+18] += t*mat2[j+18];
				dest[j+19] += t*mat2[j+19];
				dest[j+20] += t*mat2[j+20];
				dest[j+21] += t*mat2[j+21];
				dest[j+22] += t*mat2[j+22];
				dest[j+23] += t*mat2[j+23];
				dest[j+24] += t*mat2[j+24];
				dest[j+25] += t*mat2[j+25];
				dest[j+26] += t*mat2[j+26];
				dest[j+27] += t*mat2[j+27];
				dest[j+28] += t*mat2[j+28];
				dest[j+29] += t*mat2[j+29];
				dest[j+30] += t*mat2[j+30];
				dest[j+31] += t*mat2[j+31];
			}
		}
	}
}

void openmp_simd(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {

	memset(result, 0, WIDTH*HEIGHT*sizeof(double));

	#pragma omp parallel for
	for (int i = 0; i < WIDTH; i++)
	{
		for (int k = 0; k < WIDTH; k++)
		{
			__m256d t = _mm256_broadcast_sd(matrix1+i*WIDTH+k);
			for (int j = 0; j < HEIGHT; j+=4)
			{
				__m256d r = _mm256_load_pd(result+i*WIDTH+j);
				r = _mm256_fmadd_pd(_mm256_load_pd(matrix2+k*WIDTH+j), t, r);
				_mm256_store_pd(result+i*WIDTH+j, r);
			}
		}
	}
}

void openmp_simd_loopUnroll(double* restrict result,
		const double* restrict matrix1, const double* restrict matrix2) {

	const int BLOCK = 512;
	memset(result, 0, WIDTH*HEIGHT*sizeof(double));

	#pragma omp parallel
	{
		for (int kk = 0; kk < WIDTH; kk += BLOCK) {
			#pragma omp for
			for (int i = 0; i < WIDTH; i++)
			{
				for (int k = kk; k < kk+BLOCK; k++)
				{
					__m256d t = _mm256_broadcast_sd(matrix1+i*WIDTH+k);
					for (int j = 0; j < HEIGHT; j+=32)
					{
						double* dest = result+i*WIDTH+j;
						const double* mat2 = matrix2+k*WIDTH+j;
						__m256d r;
						r = _mm256_load_pd(dest);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2), t, r);
						_mm256_store_pd(dest, r);

						r = _mm256_load_pd(dest+4);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+4), t, r);
						_mm256_store_pd(dest+4, r);

						r = _mm256_load_pd(dest+8);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+8), t, r);
						_mm256_store_pd(dest+8, r);

						r = _mm256_load_pd(dest+12);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+12), t, r);
						_mm256_store_pd(dest+12, r);

						r = _mm256_load_pd(dest+16);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+16), t, r);
						_mm256_store_pd(dest+16, r);

						r = _mm256_load_pd(dest+20);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+20), t, r);
						_mm256_store_pd(dest+20, r);

						r = _mm256_load_pd(dest+24);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+24), t, r);
						_mm256_store_pd(dest+24, r);

						r = _mm256_load_pd(dest+28);
						r = _mm256_fmadd_pd(_mm256_load_pd(mat2+28), t, r);
						_mm256_store_pd(dest+28, r);
					}
				}
			}
		}
	}
}
