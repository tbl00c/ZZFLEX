//
//  WCAop_x86_64.s
//  testApp
//
//  Created by 陈秋文 on 2020/6/26.
//  Copyright © 2020 tencent. All rights reserved.
//

#if defined(__x86_64__)

.text

.globl _WCAopCodePage
#限定这个函数的存储地址按页大小(0x1000)对齐，让这个函数加载到一个独立的内存页中
.p2align  12

_WCAopCodePage:
#公共处理逻辑
L_Head_Dispatch:
    #读取保存在栈中的函数返回地址
    pop    %r11
    #获取IMP的起始地址
    andq   $0xfffffffffffffff8, %r11
    #减0x1000(页大小)获取Aop信息的地址
    sub    $0x1000, %r11
    #读取Aop信息的地址
    movq   (%r11), %r10
    #用与操作取第一页的起始地址
    andq   $0xfffffffffffff000, %r11
    #跳转到后续的处理逻辑
    jmpq   *(%r11)
    #8位对齐, 对齐后前面占用32b
    .p2align 3

    #替换函数的代码片段重复508次，508 = (4kb - 32b) / (8b)，一条汇编指令占用4b
    .rept 508
    #跳转到公共处理部分，并将外部调用的返回地址压栈
    call   L_Head_Dispatch
    #8位对齐，让单个IMP片段的占用空间达到8b
    .p2align 3
    .endr

.globl _WCAopStoreRegisterParams

_WCAopStoreRegisterParams:
    movq    %xmm7, 0x68(%r11)
    movq    %xmm6, 0x60(%r11)
    movq    %xmm5, 0x58(%r11)
    movq    %xmm4, 0x50(%r11)
    movq    %xmm3, 0x48(%r11)
    movq    %xmm2, 0x40(%r11)
    movq    %xmm1, 0x38(%r11)
    movq    %xmm0, 0x30(%r11)
    movq    %r9, 0x28(%r11)
    movq    %r8, 0x20(%r11)
    movq    %rcx, 0x18(%r11)
    movq    %rdx, 0x10(%r11)
    movq    %rsi, 0x8(%r11)
    movq    %rdi, (%r11)
    retq
.p2align  4

.globl _WCAopLoadAllParams

_WCAopLoadAllParams:
    #%rsi为外部调用时的栈底位置
    #%rdx为栈参长度
    #%rdi为WCAopGlobalSwizzle的栈底位置
    #%rcx为拷贝栈参数的地址
    cmpq    $0, %rdx
    je      L_Copy_Stack_Loop_End
    #拷贝保存在栈上的参数
    movq    %rdi, %rsi
    addq    $0xf0, %rsi
    addq    $0x10, %rsi
L_Copy_Stack_Loop:
    movq    (%rsi), %r10
    movq    %r10, (%rcx)
    addq    $0x8, %rcx
    addq    $0x8, %rsi
    subq    $0x8, %rdx
    cmp     $0, %rdx
    jnz     L_Copy_Stack_Loop
L_Copy_Stack_Loop_End:
    #加载寄存器上的值，%rdi保存寄存器值的栈底位置
    movq    0x68(%rdi), %xmm7
    movq    0x60(%rdi), %xmm6
    movq    0x58(%rdi), %xmm5
    movq    0x50(%rdi), %xmm4
    movq    0x48(%rdi), %xmm3
    movq    0x40(%rdi), %xmm2
    movq    0x38(%rdi), %xmm1
    movq    0x30(%rdi), %xmm0
    movq    0x28(%rdi), %r9
    movq    0x20(%rdi), %r8
    movq    0x18(%rdi), %rcx
    movq    0x10(%rdi), %rdx
    movq    0x8(%rdi),  %rsi
    movq    (%rdi), %rdi
    retq
.p2align  4

.globl _WCAopSaveReturnValue
#返回值的低64位存储在%rax中，高64位存储在%rdx中;如果返回值超过128位，则保存到%rdi参数传进来的栈空间，这部分栈空间由调用方分配好。
#返回的单精度浮点类型保存在%xmm0和%xmm1，双精度浮点类型则保存到浮点寄存器栈顶中。
_WCAopSaveReturnValue:
    fstpt   0x70(%rdi)
    movq    %rax, 0x80(%rdi)
    movq    %rdx, 0x88(%rdi)
    movq    %xmm0, 0x90(%rdi)
    movq    %xmm1, 0x98(%rdi)
    retq
.p2align  4

.globl _WCAopRestoreReturnValue

_WCAopRestoreReturnValue:
    fldt    0x70(%r11)
    movq    0x80(%r11), %rax
    movq    0x88(%r11), %rdx
    movq    0x90(%r11), %xmm0
    movq    0x98(%r11), %xmm1
    retq
.p2align  4

.globl _WCAopGlobalSwizzle

_WCAopGlobalSwizzle:
    pushq   %rbp
    movq    %rsp, %rbp
    //$0xf0要和kWCAopGlobalSwizzleStackSize一致
    subq    $0xf0, %rsp

    #保存当前寄存器中的参数到栈上
    movq    %rsp, %r11
    call     _WCAopStoreRegisterParams

    #获取当前Aop相关的信息
    movq    %r10, 0xe0(%rsp)
    movq    %r10, %rdx
    movq    %rsp, %rcx
    call    _WCAopGetInfo
    movq    %rax, 0xe8(%rsp)

    #执行前切面逻辑
    movq    0xc0(%rsp), %rdi
    movq    0xe0(%rsp), %rsi
    movq    0xe8(%rsp), %rdx
    call    _WCAopBeforeInvocation

    #执行当前调用或者它的替换调用
    movq    0xe0(%rsp), %rdi
    movq    0xe8(%rsp), %rsi
    leaq    0xb8(%rsp), %rdx
    call    _WCAopGetInsteadInvocation
    movq    %rsp, %rdi
    movq    0xd0(%rdi), %rdx
    subq    %rdx, %rsp
    movq    %rsp, %rcx
    call    _WCAopPrepareInsteadInvocation
    call    *%rax
    movq    %rbp, %rsp
    subq    $0xf0, %rsp
    movq    %rsp, %rdi
    call    _WCAopSaveReturnValue

    #执行后切面逻辑
    movq    0xc0(%rsp), %rdi
    movq    0xe0(%rsp), %rsi
    movq    0xe8(%rsp), %rdx
    movq    0xc8(%rsp), %rcx
    call    _WCAopAfterInvocation

    #恢复当前调用的返回值以及被调用者保存寄存器
    movq    %rsp, %r11
    call     _WCAopRestoreReturnValue
    movq    %rbp, %rsp
    popq    %rbp
    retq
.p2align  4

.globl _WCAopInvocationCall

_WCAopInvocationCall:
    pushq   %rbp
    movq    %rsp, %rbp
    cmpq    $0, %rsi
    je      L_Block_With_No_Invoke
    movq    %rsi, %rax
    movq    %rdx, %r11
    movq    0xd0(%rdi), %rdx
    subq    %rdx, %rsp
    movq    %rsp, %rcx
    call    _WCAopLoadAllParams
    movq    %rdi, %rsi
    movq    %r11, %rdi
    call    *%rax
L_Block_With_No_Invoke:
    movq    %rbp, %rsp
    popq    %rbp
    retq
.p2align  4

.globl _WCAopPrepareInsteadInvocation

_WCAopPrepareInsteadInvocation:
    movq    %rax, %r11
    movq    0xb8(%rdi), %rax
    pushq   0xd8(%rdi)
    call    _WCAopLoadAllParams

    popq    %r10
    cmpq    $0, %r11
    je      L_Prepare_Finish

    cmp     $0, %r10b
    jnz     L_Copy_Block_To_Second_Register

    movq    %rdi, %rsi
    movq    %r11, %rdi
    jmp     L_Prepare_Finish

L_Copy_Block_To_Second_Register:
    movq    %rsi, %rdx
    movq    %r11, %rsi

L_Prepare_Finish:
    retq
.p2align  4

#endif
