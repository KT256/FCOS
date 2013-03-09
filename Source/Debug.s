// Debug.s

.section .text

//   INPUT:	none
//  OUTPUT:	none
// PURPOSE:	waits for 10 seconds
// CHANGES:	none
.global Debug_Pause
Debug_Pause:
	push {r0-r3, lr}
	
	ldr r0, =10000000			// 10s
	bl Wait
	
	pop {r0-r3, pc}


//   INPUT:	none
//  OUTPUT:	none
// PURPOSE:	flashes the OK LED once
// CHANGES:	none
.global Debug_FlashOKLED
Debug_FlashOKLED:
	push {r0-r3, lr}
	
	mov r0, #16					// OK LED
	mov r1, #1					// Off
	bl SetPinOutput
	
	ldr r0, =500000				// 500ms
	bl Wait
	
	mov r0, #16					// OK LED
	mov r1, #0					// On
	bl SetPinOutput
	
	ldr r0, =500000				// 500ms
	bl Wait
	
	mov r0, #16					// OK LED
	mov r1, #1					// Off
	bl SetPinOutput
	
	ldr r0, =500000				// 500ms
	bl Wait
	
	pop {r0-r3, pc}


//   INPUT:	none
//  OUTPUT:	none
// PURPOSE:	turns the OK LED on
// CHANGES:	none
.global Debug_ActivateOKLED
Debug_ActivateOKLED:
	push {r0-r3, lr}
	
	mov r0, #16					// OK LED
	mov r1, #0					// On
	bl SetPinOutput
	
	pop {r0-r3, pc}


//   INPUT:	none
//  OUTPUT:	none
// PURPOSE:	turns the OK LED on
// CHANGES:	none
.global Debug_DeactivateOKLED
Debug_DeactivateOKLED:
	push {r0-r3, lr}
	
	mov r0, #16					// OK LED
	mov r1, #1					// Off
	bl SetPinOutput
	
	pop {r0-r3, pc}


//   INPUT:	none
// PURPOSE:	holds forever
.global Debug_Hold
Debug_Hold:
	b Debug_Hold
