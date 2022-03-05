//
//  WCAop_Arm64.s
//  testApp
//
//  Created by 陈秋文 on 2020/6/26.
//  Copyright © 2020 tencent. All rights reserved.
//

#if defined(__arm64__)

.text
.globl _WCAopCodePage
#限定这个函数的存储地址按页大小(0x4000)对齐，让这个函数加载到一个独立的内存页中
.p2align  14

_WCAopCodePage:
#公共处理逻辑
L_Head_Dispatch:
    #lr寄存器保存的是IMP片段第三条指令的地址，减8获取IMP的起始地址
    sub    x12, lr, #0x8
    #减0x4000(页大小)获取Aop信息的地址
    sub    x12, x12, #0x4000
    #恢复返回地址，这样可以直接返回到外部，而不是返回到IMP代码片段
    mov    lr, x13
    #读取Aop信息的地址
    ldr    x13, [x12]
    #将0xffffffffffffc000赋值到x11，Arm64不支持直接赋值大数
    movn   x11, #0xffff
    add    x11, x11, #0xc000
    #用与操作取第一页的起始地址
    and    x12, x12, x11
    #读取后续处理逻辑的代码地址
    ldr    x12, [x12]
    #跳转到后续的处理逻辑
    br     x12
    #8位对齐，前面9条指令，每条4b，对齐后公共处理逻辑部分占用40b
    .p2align 3
    #替换函数的代码片段重复2043次，2043 = (16kb - 40b) / 8b
    .rept 2043
    #先保存外部调用的返回地址，才能正确返回
    mov    x13, lr
    bl     L_Head_Dispatch;
    #8位对齐
    .p2align  3
    .endr

.globl _WCAopStoreRegisterParams

_WCAopStoreRegisterParams:
    stp    d6, d7, [sp, #0x80]
    stp    d4, d5, [sp, #0x70]
    stp    d2, d3, [sp, #0x60]
    stp    d0, d1, [sp, #0x50]
    str    x8, [sp, #0x40]
    stp    x6, x7, [sp, #0x30]
    stp    x4, x5, [sp, #0x20]
    stp    x2, x3, [sp, #0x10]
    stp    x0, x1, [sp]
    ret
.p2align  2

.globl    _WCAopLoadAllParams
#拷贝保存在栈上的参数
#x0为寄存器的起始保存位置
#x1为在栈上的参数的总长度
_WCAopLoadAllParams:
    cbz    x1, L_Copy_Stack_Loop_End
    add    x2, x0, #0xf0
    add    x2, x2, #0x10
    mov    x3, sp
L_Copy_Stack_Loop:
#循环将栈上的参数拷贝到当前栈底位置
    ldr    x4, [x2]
    str    x4, [x3]
    add    x3, x3, #0x8
    add    x2, x2, #0x8
    sub    x1, x1, #0x8
    cbnz   x1, L_Copy_Stack_Loop
L_Copy_Stack_Loop_End:
#恢复之前保存起来的寄存器上的值
    ldp    d6, d7, [x0, #0x80]
    ldp    d4, d5, [x0, #0x70]
    ldp    d2, d3, [x0, #0x60]
    ldp    d0, d1, [x0, #0x50]
    ldr    x8, [x0, #0x40]
    ldp    x6, x7, [x0, #0x30]
    ldp    x4, x5, [x0, #0x20]
    ldp    x2, x3, [x0, #0x10]
    ldp    x0, x1, [x0]
    ret
.p2align  2

.globl    _WCAopSaveReturnValue
#存储可能的返回值。单个整型值保存在x0中返回；对于NSRange这种大于8Byte小于等于16Byte的整型返回值，则通过x0，x1返回；对于大于16Byte的整型通过x8间接寻址返回。
#单个浮点数通过d0返回；少于五个浮点数的结构体如CGRect通过d0-d3返回；大于四个浮点数的结构体通过x8间接寻址返回。
_WCAopSaveReturnValue:
    stp    x0, x1, [sp, #0xb8]
    str    x8, [sp, #0xc8]
    stp    d0, d1, [sp, #0xd0]
    stp    d2, d3, [sp, #0xe0]
    ret
.p2align  2

.globl    _WCAopRestoreReturnValue

_WCAopRestoreReturnValue:
    ldp    x0, x1, [sp, #0xb8]
    ldr    x8, [sp, #0xc8]
    ldp    d0, d1, [sp, #0xd0]
    ldp    d2, d3, [sp, #0xe0]
    ret
.p2align  2

.globl    _WCAopGlobalSwizzle

_WCAopGlobalSwizzle:
    stp    x29, x30, [sp, #-0x10]!
    mov    x29, sp
    sub    sp, sp, #0xf0
    str    x13, [sp, #0x90]

    #保存当前寄存器中的参数到栈上
    bl     _WCAopStoreRegisterParams

    #获取当前Aop相关的信息
    ldr    x1, [sp, #0x90]
    mov    x2, sp
    mov    x3, sp
    bl     _WCAopGetInfo
    str    x0, [sp, #0x98]

    #执行前切面逻辑
    ldr    x1, [sp, #0x90]
    ldr    x2, [sp, #0x98]
    mov    x0, sp
    bl     _WCAopBeforeInvocation

    #执行当前调用或者它的替换调用
    ldr    x0, [sp, #0x90]
    ldr    x1, [sp, #0x98]
    add    x2, sp, #0xa8
    bl     _WCAopGetInsteadInvocation
    bl     _WCAopPrepareInsteadInvocation
    blr    x9
    sub    sp, x29, #0xf0
    bl     _WCAopSaveReturnValue

    #执行后切面逻辑
    ldr    x1, [sp, #0x90]
    ldr    x2, [sp, #0x98]
    mov    x0, sp
    bl     _WCAopAfterInvocation

    #恢复当前调用的返回值
    bl     _WCAopRestoreReturnValue

    mov    sp, x29
    ldp    x29, x30, [sp], #0x10
    ret
.p2align  2

.globl _WCAopInvocationCall

_WCAopInvocationCall:
    stp    x29, x30, [sp, #-0x10]!
    mov    x29, sp
    cbz    x1, L_Block_With_No_Invoke
    mov    x9, x1
    mov    x10, x2
    ldr    x1, [x0, #0xa0]
    sub    sp, sp, x1
    bl     _WCAopLoadAllParams
    mov    x1, x0
    mov    x0, x10
    blr    x9
L_Block_With_No_Invoke:
    mov    sp, x29
    ldp    x29, x30, [sp], #0x10
    ret
.p2align  2

.globl _WCAopPrepareInsteadInvocation

_WCAopPrepareInsteadInvocation:
    ldr    x9, [sp, #0xa8]
    mov    x10, x0
    mov    x0, sp
    ldr    x1, [sp, #0xa0]
    sub    sp, sp, x1
    str    x30, [sp, #-0x8]
    bl     _WCAopLoadAllParams
    ldr    x30, [sp, #-0x8]
    cbz    x10, L_No_Replace_Block
    mov    x1, x0
    mov    x0, x10
L_No_Replace_Block:
    ret
.p2align  2

#endif
