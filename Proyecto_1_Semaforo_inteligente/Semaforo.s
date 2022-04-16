.section .data
/*contador */
count: .long 0
/* Salidas */
s_north: .byte 0 /* 0 = rojo, 1 = verde,  2 = amarillo */
s_south: .byte 0 /* 0 = rojo, 1 = verde,  2 = amarillo */
s_east: .byte 0 /* 0 = rojo, 1 = verde,  2 = amarillo */
s_west: .byte 0 /* 0 = rojo, 1 = verde,  2 = amarillo */
s_ped: .byte 0 /* 0= rojo, 1= verde */
/* Entradas  booleanas*/
b_norte: .byte 0
b_sur: .byte 1
b_este: .byte 0
b_oeste: .byte 0
b_ped_walk: .byte 1

.section .text
.global _start
_start:
    mov r0, #1
    ldr r9, =count
    ldr r9, [r1]
    /* if placa norte */
    ldr r1, =b_sur
    ldr r2, [r1]
    ldr r8, =s_south
    cmp r0,r2
    bleq _sem_cycle_r8

    /* if placa este */
    ldr r1, =b_este
    ldr r2, [r1]
    ldr r8, =s_east
    cmp r0,r2
    bleq _sem_cycle_r8

    /* if placa norte */
    ldr r1, =b_norte
    ldr r2, [r1]
    ldr r8, =s_north
    cmp r0,r2
    bleq _sem_cycle_r8

    /* if placa este */
    ldr r1, =b_oeste
    ldr r2, [r1]
    ldr r8, =s_west
    cmp r0,r2
    bleq _sem_cycle_r8

    /* if placa este */
    ldr r1, =b_ped_walk
    ldr r2, [r1]
    ldr r8, =s_ped
    cmp r0,r2
    bleq _ped_cycle_r8
    bl _exit


_sem_cycle_r8:
    push {r4-r11, lr}
    mov fp, sp
    ldr r9, =count
    /* tiempo luz verde */
    bl _turn_green_r8
    mov r1,#0
    mov r10,#8
    bl _count_until_r10
    str r1,[r9] /*resets counter */

    /*tiempo luz amarilla */
    bl _turn_yellow_r8
    mov r10,#3
    bl _count_until_r10
    str r1,[r9] /*resets counter */
    bl _turn_red_r8

    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 


_ped_cycle_r8:
    push {r4-r11, lr}
    mov fp, sp 
    ldr r9, =count
    /* tiempo luz verde */
    bl _turn_green_r8
    mov r7,#0
    mov r10,#8
    bl _count_until_r10
    str r7,[r9] /*resets counter */
    bl _turn_red_r8

    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 

_count_until_r10:
    push {r8-r11, lr}
    mov fp, sp 
    bl _counting
    ldr r1,=count
    ldr r2,[r1]
    cmp r2,r10
    blt _count_until_r10

    SWI 0
    mov sp, fp
    pop {r8-r11, pc} 
    


_exit:
	MOV  r0, r3
	MOV r7, #0x01
	SWI 0

/*Sums 1 to counter data */
_counting:
    push {r8-r11, lr}
    mov fp, sp 
    ldr r0,=count
    mov r1, #0x01
    ldr r2, [r0]
    add r3, r2, r1
    str r3, [r0]
    SWI 0
    mov sp, fp
    pop {r8-r11, pc} 


/* Volver semaforo en registro 8 rojo */
_turn_red_r8:
    push {r8-r11, lr}
    mov fp, sp 
    
    mov r1, #0x0
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r8-r11, pc} 

/* Volver semaforo en registro 8 amarillo */
_turn_green_r8:
    push {r8-r11, lr}
    mov fp, sp 
    
    mov r1, #0x01
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r8-r11, pc} 
  

/* Volver semaforo en registro 8 verde */
_turn_yellow_r8:
    push {r8-r11, lr}
    mov fp, sp 
    
    mov r1, #0x02
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r8-r11, pc} 


/* 
_func:
    /* Adds the data registers into the stack to preserve its states 
    push {r4-r11, lr}
    mov fp, sp 
    /* creates the spaces needed for the function 
    sub sp,sp,#0x01

    /*Variable Examples 
    /*Loading data to variable 
    ldr r0, =semaforo_norte
    ldr r1, [r0]

    /*Storing data to variable 
    ldr r0, =semaforo_norte
    mov r2, #0x02
    str r2, [r0]

    /*Stack Examples */
    /* Loading 101 into register 1 
    ldr r1,=#0x65
    /* storing 101 into the stack 
    str r2, [fp,#-0x01]

    ldr r1, =#0x00
    ldr r2, [fp,#-0x01]


    SWI 0
    /* pops the stack to a pre _func state 
    mov sp, fp
    pop {r4-r11, pc}
*/

    