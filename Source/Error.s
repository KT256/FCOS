// Error.s

.section .text

//   INPUT:	none
// PURPOSE:	indicates an error
.global Error
Error:
	mov r0, #16					// OK LED
	mov r1, #1					// Off
	bl SetPinOutput
	
	// Hold forever
Error_loop$:
	b Error_loop$
