	.text
	.globl _compare_matrix
_compare_matrix:
LFB4740:
	vmovsd	(%rdi), %xmm0
	vsubsd	(%rsi), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %eax
	cltd
	xorl	%edx, %eax
	subl	%edx, %eax
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%eax, %xmm0, %xmm0
	vucomisd	lC0(%rip), %xmm0
	ja	L4
	movl	$8, %edx
	vmovsd	lC0(%rip), %xmm1
L3:
	vmovsd	(%rdi,%rdx), %xmm0
	vsubsd	(%rsi,%rdx), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %eax
	subl	%ecx, %eax
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	%eax, %xmm0, %xmm0
	vucomisd	%xmm1, %xmm0
	ja	L5
	addq	$8, %rdx
	cmpq	$8388608, %rdx
	jne	L3
	movl	$0, %eax
	ret
L4:
	movl	$1, %eax
	ret
L5:
	movl	$1, %eax
	ret
LFE4740:
	.literal8
	.align 3
lC0:
	.long	2665960982
	.long	1020396463
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
	.quad	LFB4740-.
	.set L$set$2,LFE4740-LFB4740
	.quad L$set$2
	.byte	0
	.align 3
LEFDE1:
	.subsections_via_symbols
