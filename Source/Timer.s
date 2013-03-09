// Timer.s

.section .text

//   INPUT:	r0:microseconds < 1 hour 11 minutes 34.967296 seconds
//  OUTPUT:	none
// PURPOSE:	waits for r0 microseconds
// CHANGES:	r1: 0x20003000
//			r2: lower portion of time in microseconds after wait
//			r3: upper portion of time in microseconds after wait
.global Wait
Wait:
	push {r4-r5, lr}
	
	ldr r1, =0x20003004			// Time address
	
	// Load current time
	ldrd r2, r3, [r1]
	add r4, r2, r0
	addvs r5, r3, #1
	movvc r5, r3
	
	// Wait for r0 microseconds
Wait_loop$:
	ldrd r2, r3, [r1]
	cmp r4, r2
	teqls r5, r3
	bne Wait_loop$
	
	pop {r4-r5, pc}
