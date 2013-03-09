// Kernel.s

.section .init
.global _start
_start:

b Run

.section .text

//   INPUT:	none
//  OUTPUT:	none
// PURPOSE:	initialises the OS
// CHANGES:	r0: 18
//			r1: current functions of pins 10~19
//			r2: 0x20200004
//			r3: current functions of pins 10~19 - 2^18
.global Init
Init:
	push {lr}
	
	mov r0, #16					// OK LED
	mov r1, #1					// Output
	bl SetPinFunction
	
	pop {pc}


//   INPUT:	none
// PURPOSE:	runs the OS
.global Run
Run:
	mov sp, #0x8000				// The first safe value
	
	bl Init
	
	mov r0, #16					// OK LED
	mov r1, #0					// On
	bl SetPinOutput
	
	// Hold forever
Run_loop$:
	b Run_loop$
