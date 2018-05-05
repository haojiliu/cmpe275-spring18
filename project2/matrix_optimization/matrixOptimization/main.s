	.text
	.cstring
lC0:
	.ascii "naive\0"
lC1:
	.ascii "openmp\0"
lC2:
	.ascii "simd\0"
lC3:
	.ascii "cache block\0"
lC4:
	.ascii "loop unroll\0"
lC5:
	.ascii "register block\0"
lC6:
	.ascii "openmp & simd\0"
lC7:
	.ascii "openmp & simd & cache block\0"
	.align 3
lC8:
	.ascii "openmp & simd & cache block & loop unroll\0"
	.align 3
lC9:
	.ascii "openmp & simd & cache block & loop unroll & register block\0"
lC13:
	.ascii "%-65s:%.3f speedup: %.4f\12\0"
lC14:
	.ascii "The result of %s is wrong\12\0"
	.section __TEXT,__text_startup,regular,pure_instructions
	.globl _main
_main:
LFB4743:
	pushq	%r15
LCFI0:
	pushq	%r14
LCFI1:
	pushq	%r13
LCFI2:
	pushq	%r12
LCFI3:
	pushq	%rbp
LCFI4:
	pushq	%rbx
LCFI5:
	subq	$392, %rsp
LCFI6:
	movl	$0, %edi
	call	_time
	movl	%eax, %edi
	call	_srand
	movl	$8, %edi
	call	_omp_set_num_threads
	leaq	304(%rsp), %rdi
	movl	$10, %ecx
	movl	$0, %eax
	rep stosq
	movq	$0, 256(%rsp)
	movq	$0, 264(%rsp)
	movq	$0, 272(%rsp)
	movq	$0, 280(%rsp)
	movq	$0, 288(%rsp)
	movq	_naive@GOTPCREL(%rip), %rax
	movq	%rax, 176(%rsp)
	movq	_openmp@GOTPCREL(%rip), %rax
	movq	%rax, 184(%rsp)
	movq	_simd@GOTPCREL(%rip), %rax
	movq	%rax, 192(%rsp)
	movq	_cacheBlock@GOTPCREL(%rip), %rax
	movq	%rax, 200(%rsp)
	movq	_loopUnroll@GOTPCREL(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	_registerBlock@GOTPCREL(%rip), %rax
	movq	%rax, 216(%rsp)
	movq	_openmp_simd@GOTPCREL(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	_openmp_simd_cacheBlock@GOTPCREL(%rip), %rax
	movq	%rax, 232(%rsp)
	movq	_openmp_simd_cacheBlock_loopUnroll@GOTPCREL(%rip), %rax
	movq	%rax, 240(%rsp)
	movq	_openmp_simd_cacheBlock_loopUnroll_registerBlock@GOTPCREL(%rip), %rax
	movq	%rax, 248(%rsp)
	leaq	lC0(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	lC1(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	lC2(%rip), %rax
	movq	%rax, 112(%rsp)
	leaq	lC3(%rip), %rax
	movq	%rax, 120(%rsp)
	leaq	lC4(%rip), %rax
	movq	%rax, 128(%rsp)
	leaq	lC5(%rip), %rax
	movq	%rax, 136(%rsp)
	leaq	lC6(%rip), %rax
	movq	%rax, 144(%rsp)
	leaq	lC7(%rip), %rax
	movq	%rax, 152(%rsp)
	leaq	lC8(%rip), %rax
	movq	%rax, 160(%rsp)
	leaq	lC9(%rip), %rax
	movq	%rax, 168(%rsp)
	movl	$1, 48(%rsp)
	movl	$1, 52(%rsp)
	movl	$1, 56(%rsp)
	movl	$1, 60(%rsp)
	movl	$1, 64(%rsp)
	movl	$1, 68(%rsp)
	movl	$1, 72(%rsp)
	movl	$1, 76(%rsp)
	movl	$1, 80(%rsp)
	movl	$1, 84(%rsp)
	movl	$0, 12(%rsp)
	jmp	L2
L19:
	movq	%rax, %rbp
	jmp	L4
L20:
	movq	%rax, %rbx
	jmp	L5
L21:
	movq	%rax, %r13
	jmp	L7
L22:
	movq	%rax, %r14
	jmp	L8
L9:
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	L10
L29:
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movq	%r14, %rdi
	call	_naive
	movq	%r14, %rsi
	movq	%r13, %rdi
	call	_compare_matrix
	movl	%eax, 256(%rsp,%r12)
	jmp	L11
L3:
	addq	$4, %r12
	cmpq	$40, %r12
	je	L28
L15:
	cmpl	$0, (%r12,%r15)
	je	L3
	movl	$8388672, %edi
	call	_malloc
	testq	%rax, %rax
	je	L19
	leaq	64(%rax), %rbp
	andq	$-64, %rbp
	movq	%rax, -8(%rbp)
L4:
	movl	$8388672, %edi
	call	_malloc
	testq	%rax, %rax
	je	L20
	leaq	64(%rax), %rbx
	andq	$-64, %rbx
	movq	%rax, -8(%rbx)
L5:
	movl	$0, %r13d
L6:
	call	_rand
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%eax, %xmm0, %xmm0
	vdivsd	lC10(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, 0(%rbp,%r13)
	call	_rand
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%eax, %xmm0, %xmm0
	vdivsd	lC10(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, (%rbx,%r13)
	addq	$8, %r13
	cmpq	$8388608, %r13
	jne	L6
	movl	$8388672, %edi
	call	_malloc
	testq	%rax, %rax
	je	L21
	leaq	64(%rax), %r13
	andq	$-64, %r13
	movq	%rax, -8(%r13)
L7:
	movl	$8388672, %edi
	call	_malloc
	testq	%rax, %rax
	je	L22
	leaq	64(%rax), %r14
	andq	$-64, %r14
	movq	%rax, -8(%r14)
L8:
	leaq	32(%rsp), %rax
	movl	$0, %esi
	movq	%rax, 24(%rsp)
	movq	%rax, %rdi
	call	_gettimeofday
	imulq	$1000000, 32(%rsp), %rdx
	movslq	40(%rsp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	%rcx, 16(%rsp)
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	*176(%rsp,%r12,2)
	movl	$0, %esi
	movq	24(%rsp), %rdi
	call	_gettimeofday
	imulq	$1000000, 32(%rsp), %rax
	movslq	40(%rsp), %rdx
	addq	%rdx, %rax
	leaq	304(%rsp), %rcx
	subq	16(%rsp), %rax
	movq	%rax, %rdx
	js	L9
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sdq	%rax, %xmm0, %xmm0
L10:
	vdivsd	lC11(%rip), %xmm0, %xmm0
	vdivsd	lC12(%rip), %xmm0, %xmm0
	vaddsd	304(%rsp,%r12,2), %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx,%r12,2)
	cmpl	$0, 12(%rsp)
	je	L29
L11:
	testq	%rbp, %rbp
	je	L12
	movq	-8(%rbp), %rdi
	call	_free
L12:
	testq	%rbx, %rbx
	je	L13
	movq	-8(%rbx), %rdi
	call	_free
L13:
	testq	%r13, %r13
	je	L14
	movq	-8(%r13), %rdi
	call	_free
L14:
	testq	%r14, %r14
	je	L3
	movq	-8(%r14), %rdi
	call	_free
	jmp	L3
L28:
	addl	$1, 12(%rsp)
	movl	12(%rsp), %eax
	cmpl	$5, %eax
	je	L23
L2:
	movl	$0, %r12d
	leaq	48(%rsp), %r15
	jmp	L15
L23:
	movl	$0, %ebx
	leaq	48(%rsp), %r12
	leaq	lC13(%rip), %r14
	leaq	256(%rsp), %rbp
	leaq	lC14(%rip), %r13
	jmp	L16
L31:
	vmovsd	304(%rsp,%rbx,2), %xmm0
	movq	96(%rsp,%rbx,2), %rsi
	vmovsd	304(%rsp), %xmm1
	vdivsd	%xmm0, %xmm1, %xmm1
	movq	%r14, %rdi
	movl	$2, %eax
	call	_printf
	jmp	L17
L18:
	addq	$4, %rbx
	cmpq	$40, %rbx
	je	L30
L16:
	cmpl	$0, (%rbx,%r12)
	jne	L31
L17:
	cmpl	$0, (%rbx,%rbp)
	je	L18
	movq	96(%rsp,%rbx,2), %rsi
	movq	%r13, %rdi
	movl	$0, %eax
	call	_printf
	jmp	L18
L30:
	movl	$0, %eax
	addq	$392, %rsp
LCFI7:
	popq	%rbx
LCFI8:
	popq	%rbp
LCFI9:
	popq	%r12
LCFI10:
	popq	%r13
LCFI11:
	popq	%r14
LCFI12:
	popq	%r15
LCFI13:
	ret
LFE4743:
	.literal8
	.align 3
lC10:
	.long	4290772992
	.long	1105199103
	.align 3
lC11:
	.long	0
	.long	1093567616
	.align 3
lC12:
	.long	0
	.long	1075052544
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0
	.byte	0x1
	.ascii "zR\0"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 3
LECIE1:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB4743-.
	.set L$set$2,LFE4743-LFB4743
	.quad L$set$2
	.byte	0
	.byte	0x4
	.set L$set$3,LCFI0-LFB4743
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x8f
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.byte	0x18
	.byte	0x8e
	.byte	0x3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.byte	0x20
	.byte	0x8d
	.byte	0x4
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xe
	.byte	0x28
	.byte	0x8c
	.byte	0x5
	.byte	0x4
	.set L$set$7,LCFI4-LCFI3
	.long L$set$7
	.byte	0xe
	.byte	0x30
	.byte	0x86
	.byte	0x6
	.byte	0x4
	.set L$set$8,LCFI5-LCFI4
	.long L$set$8
	.byte	0xe
	.byte	0x38
	.byte	0x83
	.byte	0x7
	.byte	0x4
	.set L$set$9,LCFI6-LCFI5
	.long L$set$9
	.byte	0xe
	.byte	0xc0,0x3
	.byte	0x4
	.set L$set$10,LCFI7-LCFI6
	.long L$set$10
	.byte	0xe
	.byte	0x38
	.byte	0x4
	.set L$set$11,LCFI8-LCFI7
	.long L$set$11
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$12,LCFI9-LCFI8
	.long L$set$12
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$13,LCFI10-LCFI9
	.long L$set$13
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$14,LCFI11-LCFI10
	.long L$set$14
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$15,LCFI12-LCFI11
	.long L$set$15
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$16,LCFI13-LCFI12
	.long L$set$16
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE1:
	.subsections_via_symbols
