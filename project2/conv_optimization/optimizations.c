#include "header.h"
#include <stdio.h>

void naive(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	for (int i = 0; i < WIDTH2; i++)
	{
		for (int m = 0; m < WIDTH1; m++)
		{
            for (int n = 0; n < HEIGHT1; n++)
            {
                uint64_t t = matrix1[m*WIDTH1+n];
                for (int j = 0; j < HEIGHT2; j++)
                {
                    result[i*WIDTH2+j] += t*matrix2[(i-m)*WIDTH2+(j-n)];
                }
            }
		}
	}
}



void openmp(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	#pragma omp parallel for
	for (int i = 0; i < WIDTH2; i++)
	{
		for (int m = 0; m < WIDTH1; m++)
		{
            for (int n = 0; n < HEIGHT1; n++)
            {
                uint64_t t = matrix1[m*WIDTH1+n];
                for (int j = 0; j < HEIGHT2; j++)
                {
                    result[i*WIDTH2+j] += t*matrix2[(i-m)*WIDTH2+(j-n)];
                }
            }
		}
	}
}


void simd(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	for (int i = 0; i < WIDTH2; i++)
	{
		for (int m = 0; m < WIDTH1; m++)
		{
            for (int n = 0; n < HEIGHT1; n++)
            {
                __m256i m1 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+n])));
                for (int j = 0; j < HEIGHT2; j+=4)
                {
                	__m256i r = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j));
                	__m256i m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-n));
                	m2 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
                	m2 = _mm256_mullo_epi32(m1, m2);
                	r = _mm256_add_epi64(r, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2, 0)));
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j), r);
                }
            }
		}
	}
}


void cacheBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	const int BLOCK = 512;
	for (int jj = 0; jj < WIDTH2; jj+=BLOCK) {
		for (int i = 0; i < WIDTH2; i++)
		{
			for (int m = 0; m < WIDTH1; m++)
			{
	            for (int n = 0; n < HEIGHT1; n++)
	            {
	                uint64_t t = matrix1[m*WIDTH1+n];
	                for (int j = jj; j < jj+BLOCK; j++)
	                {
	                    result[i*WIDTH2+j] += t*matrix2[(i-m)*WIDTH2+(j-n)];
	                }
	            }
			}
		}
	}
}


void loopUnroll(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	for (int i = 0; i < WIDTH2; i++)
	{
        uint64_t* dest = result + i*WIDTH2;
		for (int m = 0; m < WIDTH1; m++)
		{
            for (int n = 0; n < HEIGHT1; n++)
            {
                uint64_t t = matrix1[m*WIDTH1+n];

                const uint16_t* mat2 = matrix2 + (i-m)*WIDTH2-n;
                for (int j = 0; j < HEIGHT2; j+=32)
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
}

void registerBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {

	memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
	for (int i = 0; i < WIDTH2; i++)
	{
		for (int m = 0; m < WIDTH1; m++)
		{
			uint64_t m1_0 = matrix1[m*WIDTH1+0];
			uint64_t m1_1 = matrix1[m*WIDTH1+1];
			uint64_t m1_2 = matrix1[m*WIDTH1+2];
			uint64_t m1_3 = matrix1[m*WIDTH1+3];
			uint64_t m1_4 = matrix1[m*WIDTH1+4];
			uint64_t m1_5 = matrix1[m*WIDTH1+5];
			uint64_t m1_6 = matrix1[m*WIDTH1+6];

			for (int j = 0; j < HEIGHT2; j+=4)
			{
				uint64_t m2__6 = matrix2[(i-m)*WIDTH2+j-6];
				uint64_t m2__5 = matrix2[(i-m)*WIDTH2+j-5];
				uint64_t m2__4 = matrix2[(i-m)*WIDTH2+j-4];
				uint64_t m2__3 = matrix2[(i-m)*WIDTH2+j-3];
				uint64_t m2__2 = matrix2[(i-m)*WIDTH2+j-2];
				uint64_t m2__1 = matrix2[(i-m)*WIDTH2+j-1];
				uint64_t m2_0  = matrix2[(i-m)*WIDTH2+j+0];
				uint64_t m2_1  = matrix2[(i-m)*WIDTH2+j+1];
				uint64_t m2_2  = matrix2[(i-m)*WIDTH2+j+2];
				uint64_t m2_3  = matrix2[(i-m)*WIDTH2+j+3];

				result[i*WIDTH2+j]   += m1_0*m2_0 + m1_1*m2__1 + m1_2*m2__2 + m1_3*m2__3 + m1_4*m2__4 + m1_5*m2__5 + m1_6*m2__6;
				result[i*WIDTH2+j+1] += m1_0*m2_1 + m1_1*m2_0  + m1_2*m2__1 + m1_3*m2__2 + m1_4*m2__3 + m1_5*m2__4 + m1_6*m2__5;
				result[i*WIDTH2+j+2] += m1_0*m2_2 + m1_1*m2_1  + m1_2*m2_0  + m1_3*m2__1 + m1_4*m2__2 + m1_5*m2__3 + m1_6*m2__4;
				result[i*WIDTH2+j+3] += m1_0*m2_3 + m1_1*m2_2  + m1_2*m2_1  + m1_3*m2_0  + m1_4*m2__1 + m1_5*m2__2 + m1_6*m2__3;
			}
		}
	}
}


void openmp_simd(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
    memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
    #pragma omp parallel for
    for (int i = 0; i < WIDTH2; i++)
    {
        for (int m = 0; m < WIDTH1; m++)
        {
            for (int n = 0; n < HEIGHT1; n++)
            {
                __m256i m1 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+n])));
                for (int j = 0; j < HEIGHT2; j+=4)
                {
                	__m256i r = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j));
                	__m256i m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-n));
                	m2 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
                	m2 = _mm256_mullo_epi32(m1, m2);
                	r = _mm256_add_epi64(r, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2, 0)));
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j), r);
                }
            }
        }
    }
}


void openmp_simd_loopUnroll(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {
    memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
    #pragma omp parallel for
    for (int i = 0; i < WIDTH2; i++)
    {
        for (int m = 0; m < WIDTH1; m++)
        {
            for (int n = 0; n < HEIGHT1; n++)
            {
                __m256i m1 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+n])));
                for (int j = 0; j < HEIGHT2; j+=32)
                {
                	__m256i r0 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j));
                	__m256i r1 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+4));
                	__m256i r2 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+8));
                	__m256i r3 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+12));
                	__m256i m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-n));
                	__m256i m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
                	__m256i m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
                	m2_0 = _mm256_mullo_epi32(m1, m2_0);
                	m2_1 = _mm256_mullo_epi32(m1, m2_1);
                	r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
                	r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
                	r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
                	r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j), r0);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+4), r1);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+8), r2);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+12), r3);


                	r0 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+16));
                	r1 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+20));
                	r2 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+24));
                	r3 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+28));
                	m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-n+16));
                	m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
                	m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
                	m2_0 = _mm256_mullo_epi32(m1, m2_0);
                	m2_1 = _mm256_mullo_epi32(m1, m2_1);
                	r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
                	r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
                	r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
                	r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+16), r0);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+20), r1);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+24), r2);
                	_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+28), r3);
                }
            }
        }
    }
}


void openmp_simd_loopUnroll_registerBlock(uint64_t* restrict result,
		const uint16_t* restrict matrix1, const uint16_t* restrict matrix2) {

    memset(result, 0, WIDTH2*HEIGHT2*sizeof(uint64_t));
    #pragma omp parallel for
    for (int i = 0; i < WIDTH2; i++)
    {
        for (int m = 0; m < WIDTH1; m++)
        {
			__m256i m1_0 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1])));
			__m256i m1_1 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+1])));
			__m256i m1_2 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+2])));
			__m256i m1_3 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+3])));
			__m256i m1_4 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+4])));
			__m256i m1_5 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+5])));
			__m256i m1_6 = _mm256_set1_epi32(((uint32_t)(matrix1[m*WIDTH1+6])));

			for (int j = 0; j < HEIGHT2; j+=32)
			{
				__m256i r0 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j));
				__m256i r1 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+4));
				__m256i r2 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+8));
				__m256i r3 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+12));

				__m256i m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j));
				__m256i m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				__m256i m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_0, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_0, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-1));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_1, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_1, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-2));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_2, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_2, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-3));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_3, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_3, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-4));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_4, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_4, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-5));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_5, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_5, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-6));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_6, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_6, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j), r0);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+4), r1);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+8), r2);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+12), r3);



				r0 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+16));
				r1 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+20));
				r2 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+24));
				r3 = _mm256_loadu_si256((__m256i*)(result+i*WIDTH2+j+28));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_0, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_0, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-1+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_1, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_1, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-2+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_2, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_2, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-3+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_3, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_3, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-4+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_4, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_4, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-5+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_5, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_5, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				m2 = _mm256_loadu_si256((__m256i*)(matrix2+(i-m)*WIDTH2+j-6+16));
				m2_0 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 0));
				m2_1 = _mm256_cvtepu16_epi32(_mm256_extracti128_si256(m2, 1));
				m2_0 = _mm256_mullo_epi32(m1_6, m2_0);
				m2_1 = _mm256_mullo_epi32(m1_6, m2_1);
				r0 = _mm256_add_epi64(r0, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 0)));
				r1 = _mm256_add_epi64(r1, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_0, 1)));
				r2 = _mm256_add_epi64(r2, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 0)));
				r3 = _mm256_add_epi64(r3, _mm256_cvtepu32_epi64(_mm256_extracti128_si256(m2_1, 1)));

				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+16), r0);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+20), r1);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+24), r2);
				_mm256_storeu_si256((__m256i*)(result+i*WIDTH2+j+28), r3);
			}
        }
    }
}


