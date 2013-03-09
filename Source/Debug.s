// Debug.s

.section .text

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
