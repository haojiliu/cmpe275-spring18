	.text
_openmp._omp_fn.0:
LFB4750:
	pushq	%r13
LCFI0:
	pushq	%r12
LCFI1:
	pushq	%rbp
LCFI2:
	pushq	%rbx
LCFI3:
	subq	$8, %rsp
LCFI4:
	movq	16(%rdi), %rbx
	movq	8(%rdi), %r12
	movq	(%rdi), %rbp
	call	_omp_get_num_threads
	movl	%eax, %r13d
	call	_omp_get_thread_num
	movl	%eax, %ecx
	movl	$1024, %eax
	cltd
	idivl	%r13d
	movl	%eax, %r13d
	movl	%edx, %r11d
	cmpl	%edx, %ecx
	jl	L2
L9:
	imull	%r13d, %ecx
	addl	%ecx, %r11d
	addl	%r11d, %r13d
	cmpl	%r13d, %r11d
	jge	L1
	movl	%r11d, %r9d
	sall	$10, %r9d
	movl	$1048576, %r10d
	subl	%r9d, %r10d
	leal	1024(%r9), %edi
	jmp	L5
L16:
	addl	$1, %r11d
	subl	$1024, %r10d
	addl	$1024, %r9d
	addl	$1024, %edi
	cmpl	%r11d, %r13d
	je	L1
L5:
	leal	-1048576(%r10), %esi
	movl	%r9d, %r8d
	jmp	L4
L17:
	addl	$1, %r8d
	addl	$1024, %esi
	cmpl	%r10d, %esi
	je	L16
L4:
	movslq	%r8d, %rax
	vmovsd	(%r12,%rax,8), %xmm1
	movl	%r9d, %eax
L6:
	movslq	%eax, %rdx
	leaq	0(%rbp,%rdx,8), %rcx
	leal	(%rax,%rsi), %edx
	movslq	%edx, %rdx
	vmulsd	(%rbx,%rdx,8), %xmm1, %xmm0
	vaddsd	(%rcx), %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx)
	addl	$1, %eax
	cmpl	%edi, %eax
	jne	L6
	jmp	L17
L2:
	leal	1(%rax), %r13d
	movl	$0, %r11d
	jmp	L9
L1:
	addq	$8, %rsp
LCFI5:
	popq	%rbx
LCFI6:
	popq	%rbp
LCFI7:
	popq	%r12
LCFI8:
	popq	%r13
LCFI9:
	ret
LFE4750:
_openmp_simd._omp_fn.1:
LFB4751:
	leaq	8(%rsp), %r10
LCFI10:
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
LCFI11:
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
LCFI12:
	pushq	%rbx
	subq	$8, %rsp
LCFI13:
	movq	16(%rdi), %rbx
	movq	8(%rdi), %r13
	movq	(%rdi), %r12
	call	_omp_get_num_threads
	movl	%eax, %r14d
	call	_omp_get_thread_num
	movl	%eax, %ecx
	movl	$1024, %eax
	cltd
	idivl	%r14d
	movl	%eax, %esi
	movl	%edx, %edi
	cmpl	%edx, %ecx
	jl	L19
L26:
	movl	%ecx, %eax
	imull	%esi, %eax
	addl	%edi, %eax
	addl	%eax, %esi
	cmpl	%esi, %eax
	jge	L18
	movslq	%eax, %rcx
	movq	%rcx, %rdi
	salq	$13, %rdi
	leaq	(%r12,%rdi), %rdx
	addq	%rdi, %r13
	subl	%eax, %esi
	leal	-1(%rsi), %eax
	addq	%rcx, %rax
	salq	$13, %rax
	leaq	8192(%r12,%rax), %r8
	leaq	8388608(%rbx), %rdi
	jmp	L22
L33:
	addq	$8192, %rdx
	addq	$8192, %r13
	cmpq	%r8, %rdx
	je	L18
L22:
	movq	%rbx, %rcx
	movq	%r13, %rsi
	jmp	L21
L34:
	addq	$8, %rsi
	addq	$8192, %rcx
	cmpq	%rdi, %rcx
	je	L33
L21:
	vbroadcastsd	(%rsi), %ymm1
	movl	$0, %eax
L23:
	vmovapd	(%rcx,%rax), %ymm0
	vfmadd213pd	(%rdx,%rax), %ymm1, %ymm0
	vmovapd	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	$8192, %rax
	jne	L23
	jmp	L34
L19:
	leal	1(%rax), %esi
	movl	$0, %edi
	jmp	L26
L18:
	addq	$8, %rsp
	popq	%rbx
	popq	%r10
LCFI14:
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
LCFI15:
	ret
LFE4751:
_openmp_simd_cacheBlock._omp_fn.2:
LFB4752:
	leaq	8(%rsp), %r10
LCFI16:
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
LCFI17:
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
LCFI18:
	pushq	%rbx
	subq	$32, %rsp
LCFI19:
	movq	%rdi, %rbx
	movq	8(%rdi), %r15
	movq	(%rdi), %r13
	call	_omp_get_num_threads
	movl	%eax, %r12d
	call	_omp_get_thread_num
	movl	%eax, %ecx
	movl	$1024, %eax
	cltd
	idivl	%r12d
	leal	1(%rax), %esi
	cmpl	%edx, %ecx
	cmovl	%esi, %eax
	movq	16(%rbx), %r14
	movl	$0, %r12d
	cmovl	%r12d, %edx
	imull	%eax, %ecx
	leal	(%rdx,%rcx), %r12d
	leal	(%rax,%r12), %ebx
	movslq	%r12d, %rdx
	movq	%rdx, %rax
	salq	$13, %rax
	addq	%r13, %rax
	movq	%rax, -56(%rbp)
	movq	%rdx, %rax
	salq	$10, %rax
	movq	%rax, -64(%rbp)
	movl	%ebx, %eax
	subl	%r12d, %eax
	leal	-1(%rax), %eax
	addq	%rdx, %rax
	salq	$13, %rax
	leaq	8192(%r13,%rax), %rax
	movq	%rax, -72(%rbp)
	movl	$0, %r13d
	jmp	L36
L41:
	addq	$8192, %rdx
	addq	$8192, %r9
	cmpq	-72(%rbp), %rdx
	je	L37
L39:
	cmpl	%r8d, %r10d
	jge	L41
	movq	%r14, %rcx
	movq	%r9, %rdi
	movl	%r10d, %esi
	jmp	L38
L51:
	addl	$1, %esi
	addq	$8, %rdi
	addq	$8192, %rcx
	cmpl	%r8d, %esi
	jge	L41
L38:
	vbroadcastsd	(%rdi), %ymm1
	movl	$0, %eax
L40:
	vmovapd	(%rcx,%rax), %ymm0
	vfmadd213pd	(%rdx,%rax), %ymm1, %ymm0
	vmovapd	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	$8192, %rax
	jne	L40
	jmp	L51
L37:
	call	_GOMP_barrier
	addq	$512, %r13
	addq	$4194304, %r14
	cmpq	$1024, %r13
	je	L52
L36:
	movl	%r13d, %r10d
	cmpl	%ebx, %r12d
	jge	L37
	movq	-64(%rbp), %rax
	addq	%r13, %rax
	leaq	(%r15,%rax,8), %r9
	movq	-56(%rbp), %rdx
	leal	512(%r13), %r8d
	jmp	L39
L52:
	addq	$32, %rsp
	popq	%rbx
	popq	%r10
LCFI20:
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
LCFI21:
	ret
LFE4752:
_openmp_simd_cacheBlock_loopUnroll._omp_fn.3:
LFB4753:
	leaq	8(%rsp), %r10
LCFI22:
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
LCFI23:
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
LCFI24:
	pushq	%rbx
	subq	$32, %rsp
LCFI25:
	movq	%rdi, %rbx
	movq	(%rdi), %r12
	call	_omp_get_num_threads
	movl	%eax, %r13d
	call	_omp_get_thread_num
	movl	%eax, %ecx
	movl	$1024, %eax
	cltd
	idivl	%r13d
	leal	1(%rax), %esi
	cmpl	%edx, %ecx
	cmovl	%esi, %eax
	movq	16(%rbx), %r14
	movq	8(%rbx), %r13
	subq	%r12, %r13
	cmpl	%edx, %ecx
	movl	$0, %ebx
	cmovl	%ebx, %edx
	imull	%eax, %ecx
	leal	(%rdx,%rcx), %ebx
	leal	(%rax,%rbx), %r15d
	movslq	%ebx, %rdx
	movq	%rdx, %rax
	salq	$13, %rax
	leaq	(%r12,%rax), %rdi
	movq	%rdi, -56(%rbp)
	leaq	8192(%r12,%rax), %rax
	movq	%rax, -64(%rbp)
	movl	%r15d, %eax
	subl	%ebx, %eax
	leal	-1(%rax), %eax
	addq	%rdx, %rax
	salq	$13, %rax
	leaq	16384(%r12,%rax), %rax
	movq	%rax, -72(%rbp)
	movl	$512, %r12d
L54:
	leal	-512(%r12), %r11d
	cmpl	%r15d, %ebx
	jl	L69
L55:
	call	_GOMP_barrier
	addl	$512, %r12d
	addq	$4194304, %r14
	addq	$4096, %r13
	cmpl	$1536, %r12d
	jne	L54
	addq	$32, %rsp
	popq	%rbx
	popq	%r10
LCFI26:
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
LCFI27:
	ret
L69:
LCFI28:
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %r9
	movl	%r12d, %r10d
	leaq	-8192(%r13), %rax
	movq	%rax, -80(%rbp)
	jmp	L57
L60:
	addq	$8192, %r9
	addq	$8192, %rcx
	cmpq	-72(%rbp), %rcx
	je	L55
L57:
	cmpl	%r11d, %r12d
	jle	L60
	movq	-80(%rbp), %rax
	leaq	(%rax,%rcx), %r8
	movq	%r14, %rdi
	movl	%r11d, %esi
	jmp	L59
L70:
	addl	$1, %esi
	addq	$8, %r8
	addq	$8192, %rdi
	cmpl	%r10d, %esi
	jge	L60
L59:
	vbroadcastsd	(%r8), %ymm0
	movq	%rdi, %rdx
	movq	%r9, %rax
L58:
	vmovapd	(%rdx), %ymm1
	vfmadd213pd	(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, (%rax)
	vmovapd	32(%rdx), %ymm1
	vfmadd213pd	32(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 32(%rax)
	vmovapd	64(%rdx), %ymm1
	vfmadd213pd	64(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 64(%rax)
	vmovapd	96(%rdx), %ymm1
	vfmadd213pd	96(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 96(%rax)
	vmovapd	128(%rdx), %ymm1
	vfmadd213pd	128(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 128(%rax)
	vmovapd	160(%rdx), %ymm1
	vfmadd213pd	160(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 160(%rax)
	vmovapd	192(%rdx), %ymm1
	vfmadd213pd	192(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 192(%rax)
	vmovapd	224(%rdx), %ymm1
	vfmadd213pd	224(%rax), %ymm0, %ymm1
	vmovapd	%ymm1, 224(%rax)
	addq	$256, %rax
	addq	$256, %rdx
	cmpq	%rcx, %rax
	jne	L58
	jmp	L70
LFE4753:
_openmp_simd_cacheBlock_loopUnroll_registerBlock._omp_fn.4:
LFB4754:
	leaq	8(%rsp), %r10
LCFI29:
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
LCFI30:
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
LCFI31:
	pushq	%rbx
	subq	$32, %rsp
LCFI32:
	movq	%rdi, %r14
	movq	16(%rdi), %rbx
	movq	(%rdi), %r15
	call	_omp_get_num_threads
	movl	%eax, %r12d
	call	_omp_get_thread_num
	movl	%eax, %ecx
	movl	$1024, %eax
	cltd
	idivl	%r12d
	leal	1(%rax), %r12d
	cmpl	%edx, %ecx
	cmovl	%r12d, %eax
	movl	$0, %r13d
	cmovl	%r13d, %edx
	imull	%eax, %ecx
	leal	(%rdx,%rcx), %r13d
	leal	(%rax,%r13), %r12d
	movslq	%r13d, %rdx
	movq	%rdx, %rax
	salq	$13, %rax
	leaq	(%r15,%rax), %rdi
	movq	%rdi, -56(%rbp)
	addq	8(%r14), %rax
	movq	%rax, -64(%rbp)
	movl	%r12d, %eax
	subl	%r13d, %eax
	leal	-1(%rax), %eax
	addq	%rdx, %rax
	salq	$13, %rax
	leaq	8192(%r15,%rax), %r15
	movl	$512, %r14d
L72:
	leal	-512(%r14), %r9d
	cmpl	%r12d, %r13d
	jge	L73
	movq	-64(%rbp), %r8
	movq	-56(%rbp), %rsi
	movl	%r14d, %edi
	jmp	L75
L77:
	addq	$8192, %rsi
	addq	$8192, %r8
	cmpq	%r15, %rsi
	je	L73
L75:
	movq	%r8, %rdx
	cmpl	%r9d, %r14d
	jle	L77
	movl	%r9d, %ecx
	jmp	L74
L87:
	addl	$8, %ecx
	cmpl	%edi, %ecx
	jge	L77
L74:
	movslq	%ecx, %rax
	leaq	0(,%rax,8), %r10
	vbroadcastsd	(%rdx,%r10), %ymm15
	vbroadcastsd	8(%rdx,%r10), %ymm14
	vbroadcastsd	16(%rdx,%r10), %ymm13
	vbroadcastsd	24(%rdx,%r10), %ymm12
	vbroadcastsd	32(%rdx,%r10), %ymm11
	vbroadcastsd	40(%rdx,%r10), %ymm10
	vbroadcastsd	48(%rdx,%r10), %ymm9
	vbroadcastsd	56(%rdx,%r10), %ymm8
	salq	$13, %rax
	addq	%rbx, %rax
	leaq	8192(%rax), %r11
	movq	%rsi, %r10
L76:
	vmovapd	(%rax), %ymm7
	vfmadd213pd	(%r10), %ymm15, %ymm7
	vmovapd	32(%rax), %ymm6
	vfmadd213pd	32(%r10), %ymm15, %ymm6
	vmovapd	64(%rax), %ymm5
	vfmadd213pd	64(%r10), %ymm15, %ymm5
	vmovapd	96(%rax), %ymm4
	vfmadd213pd	96(%r10), %ymm15, %ymm4
	vmovapd	128(%rax), %ymm3
	vfmadd213pd	128(%r10), %ymm15, %ymm3
	vmovapd	160(%rax), %ymm2
	vfmadd213pd	160(%r10), %ymm15, %ymm2
	vmovapd	192(%rax), %ymm1
	vfmadd213pd	192(%r10), %ymm15, %ymm1
	vmovapd	224(%rax), %ymm0
	vfmadd213pd	224(%r10), %ymm15, %ymm0
	vfmadd231pd	8192(%rax), %ymm14, %ymm7
	vfmadd231pd	8224(%rax), %ymm14, %ymm6
	vfmadd231pd	8256(%rax), %ymm14, %ymm5
	vfmadd231pd	8288(%rax), %ymm14, %ymm4
	vfmadd231pd	8320(%rax), %ymm14, %ymm3
	vfmadd231pd	8352(%rax), %ymm14, %ymm2
	vfmadd231pd	8384(%rax), %ymm14, %ymm1
	vfmadd231pd	8416(%rax), %ymm14, %ymm0
	vfmadd231pd	16384(%rax), %ymm13, %ymm7
	vfmadd231pd	16416(%rax), %ymm13, %ymm6
	vfmadd231pd	16448(%rax), %ymm13, %ymm5
	vfmadd231pd	16480(%rax), %ymm13, %ymm4
	vfmadd231pd	16512(%rax), %ymm13, %ymm3
	vfmadd231pd	16544(%rax), %ymm13, %ymm2
	vfmadd231pd	16576(%rax), %ymm13, %ymm1
	vfmadd231pd	16608(%rax), %ymm13, %ymm0
	vfmadd231pd	24576(%rax), %ymm12, %ymm7
	vfmadd231pd	24608(%rax), %ymm12, %ymm6
	vfmadd231pd	24640(%rax), %ymm12, %ymm5
	vfmadd231pd	24672(%rax), %ymm12, %ymm4
	vfmadd231pd	24704(%rax), %ymm12, %ymm3
	vfmadd231pd	24736(%rax), %ymm12, %ymm2
	vfmadd231pd	24768(%rax), %ymm12, %ymm1
	vfmadd231pd	24800(%rax), %ymm12, %ymm0
	vfmadd231pd	32768(%rax), %ymm11, %ymm7
	vfmadd231pd	32800(%rax), %ymm11, %ymm6
	vfmadd231pd	32832(%rax), %ymm11, %ymm5
	vfmadd231pd	32864(%rax), %ymm11, %ymm4
	vfmadd231pd	32896(%rax), %ymm11, %ymm3
	vfmadd231pd	32928(%rax), %ymm11, %ymm2
	vfmadd231pd	32960(%rax), %ymm11, %ymm1
	vfmadd231pd	32992(%rax), %ymm11, %ymm0
	vfmadd231pd	40960(%rax), %ymm10, %ymm7
	vfmadd231pd	40992(%rax), %ymm10, %ymm6
	vfmadd231pd	41024(%rax), %ymm10, %ymm5
	vfmadd231pd	41056(%rax), %ymm10, %ymm4
	vfmadd231pd	41088(%rax), %ymm10, %ymm3
	vfmadd231pd	41120(%rax), %ymm10, %ymm2
	vfmadd231pd	41152(%rax), %ymm10, %ymm1
	vfmadd231pd	41184(%rax), %ymm10, %ymm0
	vfmadd231pd	49152(%rax), %ymm9, %ymm7
	vfmadd231pd	49184(%rax), %ymm9, %ymm6
	vfmadd231pd	49216(%rax), %ymm9, %ymm5
	vfmadd231pd	49248(%rax), %ymm9, %ymm4
	vfmadd231pd	49280(%rax), %ymm9, %ymm3
	vfmadd231pd	49312(%rax), %ymm9, %ymm2
	vfmadd231pd	49344(%rax), %ymm9, %ymm1
	vfmadd231pd	49376(%rax), %ymm9, %ymm0
	vfmadd231pd	57344(%rax), %ymm8, %ymm7
	vfmadd231pd	57376(%rax), %ymm8, %ymm6
	vfmadd231pd	57408(%rax), %ymm8, %ymm5
	vfmadd231pd	57440(%rax), %ymm8, %ymm4
	vfmadd231pd	57472(%rax), %ymm8, %ymm3
	vfmadd231pd	57504(%rax), %ymm8, %ymm2
	vfmadd231pd	57536(%rax), %ymm8, %ymm1
	vfmadd231pd	57568(%rax), %ymm8, %ymm0
	vmovapd	%ymm7, (%r10)
	vmovapd	%ymm6, 32(%r10)
	vmovapd	%ymm5, 64(%r10)
	vmovapd	%ymm4, 96(%r10)
	vmovapd	%ymm3, 128(%r10)
	vmovapd	%ymm2, 160(%r10)
	vmovapd	%ymm1, 192(%r10)
	vmovapd	%ymm0, 224(%r10)
	addq	$256, %r10
	addq	$256, %rax
	cmpq	%r11, %rax
	jne	L76
	jmp	L87
L73:
	call	_GOMP_barrier
	addl	$512, %r14d
	cmpl	$1536, %r14d
	jne	L72
	addq	$32, %rsp
	popq	%rbx
	popq	%r10
LCFI33:
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
LCFI34:
	ret
LFE4754:
	.globl _naive
_naive:
LFB4740:
	pushq	%r12
LCFI35:
	pushq	%rbp
LCFI36:
	pushq	%rbx
LCFI37:
	movq	%rdi, %rbx
	movq	%rsi, %r12
	movq	%rdx, %rbp
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movl	$1024, %edi
	movl	$0, %r9d
	movl	$1048576, %r11d
	jmp	L89
L91:
	movslq	%r8d, %rax
	vmovsd	(%r12,%rax,8), %xmm1
	movl	%r9d, %eax
L90:
	movslq	%eax, %rdx
	leaq	(%rbx,%rdx,8), %rcx
	leal	(%rax,%rsi), %edx
	movslq	%edx, %rdx
	vmulsd	0(%rbp,%rdx,8), %xmm1, %xmm0
	vaddsd	(%rcx), %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx)
	addl	$1, %eax
	cmpl	%edi, %eax
	jne	L90
	addl	$1, %r8d
	addl	$1024, %esi
	cmpl	%r10d, %esi
	jne	L91
	addl	$1024, %r9d
	addl	$1024, %edi
	cmpl	$1048576, %r9d
	je	L88
L89:
	movl	%r9d, %esi
	negl	%esi
	movl	%r11d, %r10d
	subl	%r9d, %r10d
	movl	%r9d, %r8d
	jmp	L91
L88:
	popq	%rbx
LCFI38:
	popq	%rbp
LCFI39:
	popq	%r12
LCFI40:
	ret
LFE4740:
	.globl _openmp
_openmp:
LFB4741:
	pushq	%r12
LCFI41:
	pushq	%rbp
LCFI42:
	pushq	%rbx
LCFI43:
	subq	$32, %rsp
LCFI44:
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movq	%rdx, %r12
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, 16(%rsp)
	movq	%rbp, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	%rsp, %rsi
	movl	$0, %ecx
	movl	$0, %edx
	leaq	_openmp._omp_fn.0(%rip), %rdi
	call	_GOMP_parallel
	addq	$32, %rsp
LCFI45:
	popq	%rbx
LCFI46:
	popq	%rbp
LCFI47:
	popq	%r12
LCFI48:
	ret
LFE4741:
	.globl _simd
_simd:
LFB4742:
	leaq	8(%rsp), %r10
LCFI49:
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
LCFI50:
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r12
	pushq	%r10
LCFI51:
	pushq	%rbx
	subq	$16, %rsp
LCFI52:
	movq	%rdi, %r12
	movq	%rsi, %r13
	movq	%rdx, %rbx
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, %rdx
	movq	%r13, %rsi
	addq	$8388608, %r12
	leaq	8388608(%rbx), %r8
	jmp	L99
L101:
	vbroadcastsd	(%rdi), %ymm1
	movl	$0, %eax
L100:
	vmovapd	(%rcx,%rax), %ymm0
	vfmadd213pd	(%rdx,%rax), %ymm1, %ymm0
	vmovapd	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	$8192, %rax
	jne	L100
	addq	$8, %rdi
	addq	$8192, %rcx
	cmpq	%r8, %rcx
	jne	L101
	addq	$8192, %rdx
	addq	$8192, %rsi
	cmpq	%r12, %rdx
	je	L98
L99:
	movq	%rbx, %rcx
	movq	%rsi, %rdi
	jmp	L101
L98:
	addq	$16, %rsp
	popq	%rbx
	popq	%r10
LCFI53:
	popq	%r12
	popq	%r13
	popq	%rbp
	leaq	-8(%r10), %rsp
LCFI54:
	ret
LFE4742:
	.globl _cacheBlock
_cacheBlock:
LFB4743:
	pushq	%r13
LCFI55:
	pushq	%r12
LCFI56:
	pushq	%rbp
LCFI57:
	pushq	%rbx
LCFI58:
	subq	$8, %rsp
LCFI59:
	movq	%rdi, %rbx
	movq	%rsi, %r12
	movq	%rdx, %rbp
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movl	$0, %r11d
L107:
	movl	%r11d, %r13d
	sall	$10, %r13d
	movl	$1024, %edi
	movl	$0, %r9d
	leal	512(%r11), %r10d
	jmp	L114
L111:
	movl	%r13d, %esi
	subl	%r9d, %esi
	movl	%r11d, %r8d
L109:
	leal	(%r8,%r9), %eax
	cltq
	vmovsd	(%r12,%rax,8), %xmm1
	movl	%r9d, %eax
L108:
	movslq	%eax, %rdx
	leaq	(%rbx,%rdx,8), %rcx
	leal	(%rax,%rsi), %edx
	movslq	%edx, %rdx
	vmulsd	0(%rbp,%rdx,8), %xmm1, %xmm0
	vaddsd	(%rcx), %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx)
	addl	$1, %eax
	cmpl	%edi, %eax
	jne	L108
	addl	$1, %r8d
	addl	$1024, %esi
	cmpl	%r10d, %r8d
	jl	L109
L112:
	addl	$1024, %r9d
	addl	$1024, %edi
	cmpl	$1048576, %r9d
	je	L110
L114:
	cmpl	%r10d, %r11d
	jl	L111
	jmp	L112
L110:
	addl	$512, %r11d
	cmpl	$1024, %r11d
	jne	L107
	addq	$8, %rsp
LCFI60:
	popq	%rbx
LCFI61:
	popq	%rbp
LCFI62:
	popq	%r12
LCFI63:
	popq	%r13
LCFI64:
	ret
LFE4743:
	.globl _loopUnroll
_loopUnroll:
LFB4744:
	pushq	%r12
LCFI65:
	pushq	%rbp
LCFI66:
	pushq	%rbx
LCFI67:
	movq	%rdi, %r12
	movq	%rsi, %rbx
	movq	%rdx, %rbp
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, %r8
	leaq	8192(%r12), %rcx
	movl	$0, %r10d
	leaq	8388608(%rbp), %r9
	jmp	L121
L127:
	addl	$1, %edi
	addq	$8192, %rsi
	cmpq	%r9, %rsi
	je	L126
L120:
	movslq	%edi, %rax
	vmovsd	(%rbx,%rax,8), %xmm0
	movq	%rsi, %rdx
	movq	%r8, %rax
L119:
	vmulsd	(%rdx), %xmm0, %xmm1
	vaddsd	(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, (%rax)
	vmulsd	8(%rdx), %xmm0, %xmm1
	vaddsd	8(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 8(%rax)
	vmulsd	16(%rdx), %xmm0, %xmm1
	vaddsd	16(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 16(%rax)
	vmulsd	24(%rdx), %xmm0, %xmm1
	vaddsd	24(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 24(%rax)
	vmulsd	32(%rdx), %xmm0, %xmm1
	vaddsd	32(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 32(%rax)
	vmulsd	40(%rdx), %xmm0, %xmm1
	vaddsd	40(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 40(%rax)
	vmulsd	48(%rdx), %xmm0, %xmm1
	vaddsd	48(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 48(%rax)
	vmulsd	56(%rdx), %xmm0, %xmm1
	vaddsd	56(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 56(%rax)
	vmulsd	64(%rdx), %xmm0, %xmm1
	vaddsd	64(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 64(%rax)
	vmulsd	72(%rdx), %xmm0, %xmm1
	vaddsd	72(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 72(%rax)
	vmulsd	80(%rdx), %xmm0, %xmm1
	vaddsd	80(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 80(%rax)
	vmulsd	88(%rdx), %xmm0, %xmm1
	vaddsd	88(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 88(%rax)
	vmulsd	96(%rdx), %xmm0, %xmm1
	vaddsd	96(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 96(%rax)
	vmulsd	104(%rdx), %xmm0, %xmm1
	vaddsd	104(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 104(%rax)
	vmulsd	112(%rdx), %xmm0, %xmm1
	vaddsd	112(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 112(%rax)
	vmulsd	120(%rdx), %xmm0, %xmm1
	vaddsd	120(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 120(%rax)
	vmulsd	128(%rdx), %xmm0, %xmm1
	vaddsd	128(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 128(%rax)
	vmulsd	136(%rdx), %xmm0, %xmm1
	vaddsd	136(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 136(%rax)
	vmulsd	144(%rdx), %xmm0, %xmm1
	vaddsd	144(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 144(%rax)
	vmulsd	152(%rdx), %xmm0, %xmm1
	vaddsd	152(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 152(%rax)
	vmulsd	160(%rdx), %xmm0, %xmm1
	vaddsd	160(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 160(%rax)
	vmulsd	168(%rdx), %xmm0, %xmm1
	vaddsd	168(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 168(%rax)
	vmulsd	176(%rdx), %xmm0, %xmm1
	vaddsd	176(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 176(%rax)
	vmulsd	184(%rdx), %xmm0, %xmm1
	vaddsd	184(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 184(%rax)
	vmulsd	192(%rdx), %xmm0, %xmm1
	vaddsd	192(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 192(%rax)
	vmulsd	200(%rdx), %xmm0, %xmm1
	vaddsd	200(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 200(%rax)
	vmulsd	208(%rdx), %xmm0, %xmm1
	vaddsd	208(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 208(%rax)
	vmulsd	216(%rdx), %xmm0, %xmm1
	vaddsd	216(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 216(%rax)
	vmulsd	224(%rdx), %xmm0, %xmm1
	vaddsd	224(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 224(%rax)
	vmulsd	232(%rdx), %xmm0, %xmm1
	vaddsd	232(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 232(%rax)
	vmulsd	240(%rdx), %xmm0, %xmm1
	vaddsd	240(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 240(%rax)
	vmulsd	248(%rdx), %xmm0, %xmm1
	vaddsd	248(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, 248(%rax)
	addq	$256, %rax
	addq	$256, %rdx
	cmpq	%rcx, %rax
	jne	L119
	jmp	L127
L126:
	addq	$8192, %r8
	addq	$8192, %rcx
	addl	$1024, %r10d
	cmpl	$1048576, %r10d
	je	L128
L121:
	movq	%rbp, %rsi
	movl	%r10d, %edi
	jmp	L120
L128:
	popq	%rbx
LCFI68:
	popq	%rbp
LCFI69:
	popq	%r12
LCFI70:
	ret
LFE4744:
	.globl _registerBlock
_registerBlock:
LFB4745:
	pushq	%r12
LCFI71:
	pushq	%rbp
LCFI72:
	pushq	%rbx
LCFI73:
	movq	%rdi, %rbp
	movq	%rsi, %r12
	movq	%rdx, %rbx
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%rbp, %r9
	movq	%r12, %rsi
	leaq	8388608(%rbp), %r11
	leaq	8388608(%rbx), %r10
L132:
	movq	%rbx, %r8
	movq	%rsi, %rdi
L131:
	vmovsd	(%rdi), %xmm7
	vmovsd	8(%rdi), %xmm6
	vmovsd	16(%rdi), %xmm5
	vmovsd	24(%rdi), %xmm4
	leaq	8192(%r8), %rcx
	movq	%r8, %rax
	movq	%r9, %rdx
L130:
	vmulsd	(%rax), %xmm7, %xmm8
	vaddsd	(%rdx), %xmm8, %xmm8
	vmulsd	8(%rax), %xmm7, %xmm3
	vaddsd	8(%rdx), %xmm3, %xmm3
	vmulsd	16(%rax), %xmm7, %xmm2
	vaddsd	16(%rdx), %xmm2, %xmm2
	vmulsd	24(%rax), %xmm7, %xmm0
	vaddsd	24(%rdx), %xmm0, %xmm0
	vmulsd	8192(%rax), %xmm6, %xmm1
	vaddsd	%xmm8, %xmm1, %xmm8
	vmulsd	8200(%rax), %xmm6, %xmm1
	vaddsd	%xmm3, %xmm1, %xmm3
	vmulsd	8208(%rax), %xmm6, %xmm1
	vaddsd	%xmm2, %xmm1, %xmm2
	vmulsd	8216(%rax), %xmm6, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmulsd	16384(%rax), %xmm5, %xmm1
	vaddsd	%xmm8, %xmm1, %xmm8
	vmulsd	16392(%rax), %xmm5, %xmm1
	vaddsd	%xmm3, %xmm1, %xmm3
	vmulsd	16400(%rax), %xmm5, %xmm1
	vaddsd	%xmm2, %xmm1, %xmm2
	vmulsd	16408(%rax), %xmm5, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmulsd	24584(%rax), %xmm4, %xmm1
	vaddsd	%xmm3, %xmm1, %xmm3
	vmulsd	24592(%rax), %xmm4, %xmm1
	vaddsd	%xmm2, %xmm1, %xmm2
	vmulsd	24600(%rax), %xmm4, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmulsd	24576(%rax), %xmm4, %xmm1
	vaddsd	%xmm8, %xmm1, %xmm1
	vmovsd	%xmm1, (%rdx)
	vmovsd	%xmm3, 8(%rdx)
	vmovsd	%xmm2, 16(%rdx)
	vmovsd	%xmm0, 24(%rdx)
	addq	$32, %rdx
	addq	$32, %rax
	cmpq	%rcx, %rax
	jne	L130
	addq	$32, %rdi
	addq	$32768, %r8
	cmpq	%r10, %r8
	jne	L131
	addq	$8192, %r9
	addq	$8192, %rsi
	cmpq	%r11, %r9
	jne	L132
	popq	%rbx
LCFI74:
	popq	%rbp
LCFI75:
	popq	%r12
LCFI76:
	ret
LFE4745:
	.globl _openmp_simd
_openmp_simd:
LFB4746:
	pushq	%r12
LCFI77:
	pushq	%rbp
LCFI78:
	pushq	%rbx
LCFI79:
	subq	$32, %rsp
LCFI80:
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movq	%rdx, %r12
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, 16(%rsp)
	movq	%rbp, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	%rsp, %rsi
	movl	$0, %ecx
	movl	$0, %edx
	leaq	_openmp_simd._omp_fn.1(%rip), %rdi
	call	_GOMP_parallel
	addq	$32, %rsp
LCFI81:
	popq	%rbx
LCFI82:
	popq	%rbp
LCFI83:
	popq	%r12
LCFI84:
	ret
LFE4746:
	.globl _openmp_simd_cacheBlock
_openmp_simd_cacheBlock:
LFB4747:
	pushq	%r12
LCFI85:
	pushq	%rbp
LCFI86:
	pushq	%rbx
LCFI87:
	subq	$32, %rsp
LCFI88:
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movq	%rdx, %r12
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, 16(%rsp)
	movq	%rbp, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	%rsp, %rsi
	movl	$0, %ecx
	movl	$0, %edx
	leaq	_openmp_simd_cacheBlock._omp_fn.2(%rip), %rdi
	call	_GOMP_parallel
	addq	$32, %rsp
LCFI89:
	popq	%rbx
LCFI90:
	popq	%rbp
LCFI91:
	popq	%r12
LCFI92:
	ret
LFE4747:
	.globl _openmp_simd_cacheBlock_loopUnroll
_openmp_simd_cacheBlock_loopUnroll:
LFB4748:
	pushq	%r12
LCFI93:
	pushq	%rbp
LCFI94:
	pushq	%rbx
LCFI95:
	subq	$32, %rsp
LCFI96:
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movq	%rdx, %r12
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, 16(%rsp)
	movq	%rbp, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	%rsp, %rsi
	movl	$0, %ecx
	movl	$0, %edx
	leaq	_openmp_simd_cacheBlock_loopUnroll._omp_fn.3(%rip), %rdi
	call	_GOMP_parallel
	addq	$32, %rsp
LCFI97:
	popq	%rbx
LCFI98:
	popq	%rbp
LCFI99:
	popq	%r12
LCFI100:
	ret
LFE4748:
	.globl _openmp_simd_cacheBlock_loopUnroll_registerBlock
_openmp_simd_cacheBlock_loopUnroll_registerBlock:
LFB4749:
	pushq	%r12
LCFI101:
	pushq	%rbp
LCFI102:
	pushq	%rbx
LCFI103:
	subq	$32, %rsp
LCFI104:
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movq	%rdx, %r12
	movl	$8388608, %edx
	movl	$0, %esi
	call	_memset
	movq	%r12, 16(%rsp)
	movq	%rbp, 8(%rsp)
	movq	%rbx, (%rsp)
	movq	%rsp, %rsi
	movl	$0, %ecx
	movl	$0, %edx
	leaq	_openmp_simd_cacheBlock_loopUnroll_registerBlock._omp_fn.4(%rip), %rdi
	call	_GOMP_parallel
	addq	$32, %rsp
LCFI105:
	popq	%rbx
LCFI106:
	popq	%rbp
LCFI107:
	popq	%r12
LCFI108:
	ret
LFE4749:
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
	.quad	LFB4750-.
	.set L$set$2,LFE4750-LFB4750
	.quad L$set$2
	.byte	0
	.byte	0x4
	.set L$set$3,LCFI0-LFB4750
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x8d
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.byte	0x18
	.byte	0x8c
	.byte	0x3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.byte	0x20
	.byte	0x86
	.byte	0x4
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xe
	.byte	0x28
	.byte	0x83
	.byte	0x5
	.byte	0x4
	.set L$set$7,LCFI4-LCFI3
	.long L$set$7
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$8,LCFI5-LCFI4
	.long L$set$8
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$9,LCFI6-LCFI5
	.long L$set$9
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$10,LCFI7-LCFI6
	.long L$set$10
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$11,LCFI8-LCFI7
	.long L$set$11
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$12,LCFI9-LCFI8
	.long L$set$12
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$13,LEFDE3-LASFDE3
	.long L$set$13
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB4751-.
	.set L$set$14,LFE4751-LFB4751
	.quad L$set$14
	.byte	0
	.byte	0x4
	.set L$set$15,LCFI10-LFB4751
	.long L$set$15
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$16,LCFI11-LCFI10
	.long L$set$16
	.byte	0x10
	.byte	0x6
	.byte	0x2
	.byte	0x76
	.byte	0
	.byte	0x4
	.set L$set$17,LCFI12-LCFI11
	.long L$set$17
	.byte	0xf
	.byte	0x3
	.byte	0x76
	.byte	0x60
	.byte	0x6
	.byte	0x10
	.byte	0xe
	.byte	0x2
	.byte	0x76
	.byte	0x78
	.byte	0x10
	.byte	0xd
	.byte	0x2
	.byte	0x76
	.byte	0x70
	.byte	0x10
	.byte	0xc
	.byte	0x2
	.byte	0x76
	.byte	0x68
	.byte	0x4
	.set L$set$18,LCFI13-LCFI12
	.long L$set$18
	.byte	0x10
	.byte	0x3
	.byte	0x2
	.byte	0x76
	.byte	0x58
	.byte	0x4
	.set L$set$19,LCFI14-LCFI13
	.long L$set$19
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$20,LCFI15-LCFI14
	.long L$set$20
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE3:
LSFDE5:
	.set L$set$21,LEFDE5-LASFDE5
	.long L$set$21
LASFDE5:
	.long	LASFDE5-EH_frame1
	.quad	LFB4752-.
	.set L$set$22,LFE4752-LFB4752
	.quad L$set$22
	.byte	0
	.byte	0x4
	.set L$set$23,LCFI16-LFB4752
	.long L$set$23
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$24,LCFI17-LCFI16
	.long L$set$24
	.byte	0x10
	.byte	0x6
	.byte	0x2
	.byte	0x76
	.byte	0
	.byte	0x4
	.set L$set$25,LCFI18-LCFI17
	.long L$set$25
	.byte	0xf
	.byte	0x3
	.byte	0x76
	.byte	0x58
	.byte	0x6
	.byte	0x10
	.byte	0xf
	.byte	0x2
	.byte	0x76
	.byte	0x78
	.byte	0x10
	.byte	0xe
	.byte	0x2
	.byte	0x76
	.byte	0x70
	.byte	0x10
	.byte	0xd
	.byte	0x2
	.byte	0x76
	.byte	0x68
	.byte	0x10
	.byte	0xc
	.byte	0x2
	.byte	0x76
	.byte	0x60
	.byte	0x4
	.set L$set$26,LCFI19-LCFI18
	.long L$set$26
	.byte	0x10
	.byte	0x3
	.byte	0x2
	.byte	0x76
	.byte	0x50
	.byte	0x4
	.set L$set$27,LCFI20-LCFI19
	.long L$set$27
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$28,LCFI21-LCFI20
	.long L$set$28
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE5:
LSFDE7:
	.set L$set$29,LEFDE7-LASFDE7
	.long L$set$29
LASFDE7:
	.long	LASFDE7-EH_frame1
	.quad	LFB4753-.
	.set L$set$30,LFE4753-LFB4753
	.quad L$set$30
	.byte	0
	.byte	0x4
	.set L$set$31,LCFI22-LFB4753
	.long L$set$31
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$32,LCFI23-LCFI22
	.long L$set$32
	.byte	0x10
	.byte	0x6
	.byte	0x2
	.byte	0x76
	.byte	0
	.byte	0x4
	.set L$set$33,LCFI24-LCFI23
	.long L$set$33
	.byte	0xf
	.byte	0x3
	.byte	0x76
	.byte	0x58
	.byte	0x6
	.byte	0x10
	.byte	0xf
	.byte	0x2
	.byte	0x76
	.byte	0x78
	.byte	0x10
	.byte	0xe
	.byte	0x2
	.byte	0x76
	.byte	0x70
	.byte	0x10
	.byte	0xd
	.byte	0x2
	.byte	0x76
	.byte	0x68
	.byte	0x10
	.byte	0xc
	.byte	0x2
	.byte	0x76
	.byte	0x60
	.byte	0x4
	.set L$set$34,LCFI25-LCFI24
	.long L$set$34
	.byte	0x10
	.byte	0x3
	.byte	0x2
	.byte	0x76
	.byte	0x50
	.byte	0x4
	.set L$set$35,LCFI26-LCFI25
	.long L$set$35
	.byte	0xa
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$36,LCFI27-LCFI26
	.long L$set$36
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x4
	.set L$set$37,LCFI28-LCFI27
	.long L$set$37
	.byte	0xb
	.align 3
LEFDE7:
LSFDE9:
	.set L$set$38,LEFDE9-LASFDE9
	.long L$set$38
LASFDE9:
	.long	LASFDE9-EH_frame1
	.quad	LFB4754-.
	.set L$set$39,LFE4754-LFB4754
	.quad L$set$39
	.byte	0
	.byte	0x4
	.set L$set$40,LCFI29-LFB4754
	.long L$set$40
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$41,LCFI30-LCFI29
	.long L$set$41
	.byte	0x10
	.byte	0x6
	.byte	0x2
	.byte	0x76
	.byte	0
	.byte	0x4
	.set L$set$42,LCFI31-LCFI30
	.long L$set$42
	.byte	0xf
	.byte	0x3
	.byte	0x76
	.byte	0x58
	.byte	0x6
	.byte	0x10
	.byte	0xf
	.byte	0x2
	.byte	0x76
	.byte	0x78
	.byte	0x10
	.byte	0xe
	.byte	0x2
	.byte	0x76
	.byte	0x70
	.byte	0x10
	.byte	0xd
	.byte	0x2
	.byte	0x76
	.byte	0x68
	.byte	0x10
	.byte	0xc
	.byte	0x2
	.byte	0x76
	.byte	0x60
	.byte	0x4
	.set L$set$43,LCFI32-LCFI31
	.long L$set$43
	.byte	0x10
	.byte	0x3
	.byte	0x2
	.byte	0x76
	.byte	0x50
	.byte	0x4
	.set L$set$44,LCFI33-LCFI32
	.long L$set$44
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$45,LCFI34-LCFI33
	.long L$set$45
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE9:
LSFDE11:
	.set L$set$46,LEFDE11-LASFDE11
	.long L$set$46
LASFDE11:
	.long	LASFDE11-EH_frame1
	.quad	LFB4740-.
	.set L$set$47,LFE4740-LFB4740
	.quad L$set$47
	.byte	0
	.byte	0x4
	.set L$set$48,LCFI35-LFB4740
	.long L$set$48
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$49,LCFI36-LCFI35
	.long L$set$49
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$50,LCFI37-LCFI36
	.long L$set$50
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$51,LCFI38-LCFI37
	.long L$set$51
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$52,LCFI39-LCFI38
	.long L$set$52
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$53,LCFI40-LCFI39
	.long L$set$53
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE11:
LSFDE13:
	.set L$set$54,LEFDE13-LASFDE13
	.long L$set$54
LASFDE13:
	.long	LASFDE13-EH_frame1
	.quad	LFB4741-.
	.set L$set$55,LFE4741-LFB4741
	.quad L$set$55
	.byte	0
	.byte	0x4
	.set L$set$56,LCFI41-LFB4741
	.long L$set$56
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$57,LCFI42-LCFI41
	.long L$set$57
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$58,LCFI43-LCFI42
	.long L$set$58
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$59,LCFI44-LCFI43
	.long L$set$59
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$60,LCFI45-LCFI44
	.long L$set$60
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$61,LCFI46-LCFI45
	.long L$set$61
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$62,LCFI47-LCFI46
	.long L$set$62
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$63,LCFI48-LCFI47
	.long L$set$63
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE13:
LSFDE15:
	.set L$set$64,LEFDE15-LASFDE15
	.long L$set$64
LASFDE15:
	.long	LASFDE15-EH_frame1
	.quad	LFB4742-.
	.set L$set$65,LFE4742-LFB4742
	.quad L$set$65
	.byte	0
	.byte	0x4
	.set L$set$66,LCFI49-LFB4742
	.long L$set$66
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$67,LCFI50-LCFI49
	.long L$set$67
	.byte	0x10
	.byte	0x6
	.byte	0x2
	.byte	0x76
	.byte	0
	.byte	0x4
	.set L$set$68,LCFI51-LCFI50
	.long L$set$68
	.byte	0xf
	.byte	0x3
	.byte	0x76
	.byte	0x68
	.byte	0x6
	.byte	0x10
	.byte	0xd
	.byte	0x2
	.byte	0x76
	.byte	0x78
	.byte	0x10
	.byte	0xc
	.byte	0x2
	.byte	0x76
	.byte	0x70
	.byte	0x4
	.set L$set$69,LCFI52-LCFI51
	.long L$set$69
	.byte	0x10
	.byte	0x3
	.byte	0x2
	.byte	0x76
	.byte	0x60
	.byte	0x4
	.set L$set$70,LCFI53-LCFI52
	.long L$set$70
	.byte	0xc
	.byte	0xa
	.byte	0
	.byte	0x4
	.set L$set$71,LCFI54-LCFI53
	.long L$set$71
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE15:
LSFDE17:
	.set L$set$72,LEFDE17-LASFDE17
	.long L$set$72
LASFDE17:
	.long	LASFDE17-EH_frame1
	.quad	LFB4743-.
	.set L$set$73,LFE4743-LFB4743
	.quad L$set$73
	.byte	0
	.byte	0x4
	.set L$set$74,LCFI55-LFB4743
	.long L$set$74
	.byte	0xe
	.byte	0x10
	.byte	0x8d
	.byte	0x2
	.byte	0x4
	.set L$set$75,LCFI56-LCFI55
	.long L$set$75
	.byte	0xe
	.byte	0x18
	.byte	0x8c
	.byte	0x3
	.byte	0x4
	.set L$set$76,LCFI57-LCFI56
	.long L$set$76
	.byte	0xe
	.byte	0x20
	.byte	0x86
	.byte	0x4
	.byte	0x4
	.set L$set$77,LCFI58-LCFI57
	.long L$set$77
	.byte	0xe
	.byte	0x28
	.byte	0x83
	.byte	0x5
	.byte	0x4
	.set L$set$78,LCFI59-LCFI58
	.long L$set$78
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$79,LCFI60-LCFI59
	.long L$set$79
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$80,LCFI61-LCFI60
	.long L$set$80
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$81,LCFI62-LCFI61
	.long L$set$81
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$82,LCFI63-LCFI62
	.long L$set$82
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$83,LCFI64-LCFI63
	.long L$set$83
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE17:
LSFDE19:
	.set L$set$84,LEFDE19-LASFDE19
	.long L$set$84
LASFDE19:
	.long	LASFDE19-EH_frame1
	.quad	LFB4744-.
	.set L$set$85,LFE4744-LFB4744
	.quad L$set$85
	.byte	0
	.byte	0x4
	.set L$set$86,LCFI65-LFB4744
	.long L$set$86
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$87,LCFI66-LCFI65
	.long L$set$87
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$88,LCFI67-LCFI66
	.long L$set$88
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$89,LCFI68-LCFI67
	.long L$set$89
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$90,LCFI69-LCFI68
	.long L$set$90
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$91,LCFI70-LCFI69
	.long L$set$91
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE19:
LSFDE21:
	.set L$set$92,LEFDE21-LASFDE21
	.long L$set$92
LASFDE21:
	.long	LASFDE21-EH_frame1
	.quad	LFB4745-.
	.set L$set$93,LFE4745-LFB4745
	.quad L$set$93
	.byte	0
	.byte	0x4
	.set L$set$94,LCFI71-LFB4745
	.long L$set$94
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$95,LCFI72-LCFI71
	.long L$set$95
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$96,LCFI73-LCFI72
	.long L$set$96
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$97,LCFI74-LCFI73
	.long L$set$97
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$98,LCFI75-LCFI74
	.long L$set$98
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$99,LCFI76-LCFI75
	.long L$set$99
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE21:
LSFDE23:
	.set L$set$100,LEFDE23-LASFDE23
	.long L$set$100
LASFDE23:
	.long	LASFDE23-EH_frame1
	.quad	LFB4746-.
	.set L$set$101,LFE4746-LFB4746
	.quad L$set$101
	.byte	0
	.byte	0x4
	.set L$set$102,LCFI77-LFB4746
	.long L$set$102
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$103,LCFI78-LCFI77
	.long L$set$103
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$104,LCFI79-LCFI78
	.long L$set$104
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$105,LCFI80-LCFI79
	.long L$set$105
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$106,LCFI81-LCFI80
	.long L$set$106
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$107,LCFI82-LCFI81
	.long L$set$107
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$108,LCFI83-LCFI82
	.long L$set$108
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$109,LCFI84-LCFI83
	.long L$set$109
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE23:
LSFDE25:
	.set L$set$110,LEFDE25-LASFDE25
	.long L$set$110
LASFDE25:
	.long	LASFDE25-EH_frame1
	.quad	LFB4747-.
	.set L$set$111,LFE4747-LFB4747
	.quad L$set$111
	.byte	0
	.byte	0x4
	.set L$set$112,LCFI85-LFB4747
	.long L$set$112
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$113,LCFI86-LCFI85
	.long L$set$113
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$114,LCFI87-LCFI86
	.long L$set$114
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$115,LCFI88-LCFI87
	.long L$set$115
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$116,LCFI89-LCFI88
	.long L$set$116
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$117,LCFI90-LCFI89
	.long L$set$117
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$118,LCFI91-LCFI90
	.long L$set$118
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$119,LCFI92-LCFI91
	.long L$set$119
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE25:
LSFDE27:
	.set L$set$120,LEFDE27-LASFDE27
	.long L$set$120
LASFDE27:
	.long	LASFDE27-EH_frame1
	.quad	LFB4748-.
	.set L$set$121,LFE4748-LFB4748
	.quad L$set$121
	.byte	0
	.byte	0x4
	.set L$set$122,LCFI93-LFB4748
	.long L$set$122
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$123,LCFI94-LCFI93
	.long L$set$123
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$124,LCFI95-LCFI94
	.long L$set$124
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$125,LCFI96-LCFI95
	.long L$set$125
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$126,LCFI97-LCFI96
	.long L$set$126
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$127,LCFI98-LCFI97
	.long L$set$127
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$128,LCFI99-LCFI98
	.long L$set$128
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$129,LCFI100-LCFI99
	.long L$set$129
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE27:
LSFDE29:
	.set L$set$130,LEFDE29-LASFDE29
	.long L$set$130
LASFDE29:
	.long	LASFDE29-EH_frame1
	.quad	LFB4749-.
	.set L$set$131,LFE4749-LFB4749
	.quad L$set$131
	.byte	0
	.byte	0x4
	.set L$set$132,LCFI101-LFB4749
	.long L$set$132
	.byte	0xe
	.byte	0x10
	.byte	0x8c
	.byte	0x2
	.byte	0x4
	.set L$set$133,LCFI102-LCFI101
	.long L$set$133
	.byte	0xe
	.byte	0x18
	.byte	0x86
	.byte	0x3
	.byte	0x4
	.set L$set$134,LCFI103-LCFI102
	.long L$set$134
	.byte	0xe
	.byte	0x20
	.byte	0x83
	.byte	0x4
	.byte	0x4
	.set L$set$135,LCFI104-LCFI103
	.long L$set$135
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$136,LCFI105-LCFI104
	.long L$set$136
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$137,LCFI106-LCFI105
	.long L$set$137
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$138,LCFI107-LCFI106
	.long L$set$138
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$139,LCFI108-LCFI107
	.long L$set$139
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE29:
	.subsections_via_symbols
