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
b_sur: .byte 0
b_este: .byte 0
b_oeste: .byte 0
b_ped_walk: .byte 0

.section .text
.global _start
_start:
    bl _counting
    /*ldr r8, =s_north
    bl _turn_green_r0*/
    bl _exit

_exit:
	MOV  r0, r3
	MOV r7, #0x01
	SWI 0

/*Sums 1 to counter data */
_counting:
    push {r4-r11, lr}
    mov fp, sp 
    ldr r0,=count
    mov r1, #0x01
    ldr r2, [r0]
    add r3, r2, r1
    str r3, [r0]
    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 


/* Volver semaforo en registro 0 rojo */
_turn_red_r8:
    push {r4-r11, lr}
    mov fp, sp 
    
    mov r1, #0x0
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 

/* Volver semaforo en registro 0 amarillo */
_turn_green_r8:
    push {r4-r11, lr}
    mov fp, sp 
    
    mov r1, #0x01
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 
  

/* Volver semaforo en registro 0 verde */
_turn_yellow_r8:
    push {r4-r11, lr}
    mov fp, sp 
    
    mov r1, #0x02
    str r1, [r8]

    SWI 0
    mov sp, fp
    pop {r4-r11, pc} 


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

    