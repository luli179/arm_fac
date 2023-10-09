    .arch armv7-a
    .comm f,4   @阶乘结果
    .comm i,4
    .comm n,4   @n的阶乘
    .text
    .align 2
    
    .align
    .section .rodata
    .align 2
_str0:
    .ascii "%d\0"
    .align 2
_str1:
    .ascii "error\n"  @n小于0时输出错误
    .align 2
_str2:
    .ascii "outcome is : %d\n\0"   @输出结果

    .align 2
    .global fac
fac:              @function int fac(int n)
    str fp, [sp, #-4]!
    mov fp, sp
    ldr r1, =f    @读取f
    ldr r2, [r1]
    ldr r1, =i    @读取i
    ldr r3, [r1]
.loop:
    cmp r0, r3    @比较n与i大小，如果n<i结束循环
    blt .end
    mul r2, r2, r3    @f*=i
    add r3, r3, #1    @i+=1
    b .loop


.end:       @结束，f值写入r0,作为返回值
    mov r0, r2
    add sp, fp, #0
    ldr fp, [sp], #4
    bx lr
    


    .global main
main:
    push {fp, lr}
    add fp, sp, #4

    ldr r0, =f  @ f=1
    mov r1, #1
    str r1, [r0]

    ldr r0, =i   @ i=2
    mov r1, #2
    str r1, [r0]

    ldr r1, =n    @读取n
    ldr r0, =_str0
    bl scanf

    ldr r3, =n
    ldr r0, [r3]
    cmp r0, #0    @比较n与0的大小关系
    blt .error
    cmp r0, #0
    bge .cor

.error:          @打印错误
    ldr r0, =_str1
    bl printf
    mov r0, #0
    pop {fp, pc}

.cor:          @调用阶乘函数
    bl fac
    mov r1, r0      
    ldr r0, =_str2
    bl printf    @打印结果
    mov r0, #0
    pop {fp, pc}
        

    
    
    
    
    