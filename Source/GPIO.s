// GPIO.s

.section .text

//   INPUT:	r0:pin < 54, r1:function < 8
//  OUTPUT:	none
// PURPOSE:	sets pin r0 for function r1
// CHANGES:	r0: pin % 10 * 3,
//			r1: new value at that address,
//			r2: 0x2020000(0|4)
//			r3: value of all other pins at that address
.global SetPinFunction
SetPinFunction:
	// Exit if invalid inputs
	cmp r0, #53
	cmpls r1, #7
	bhi Error
	
	push {lr}
	
	ldr r2, =0x20200000			// GPIO address
	
	// Set r0 to the address of the 32bit integer containing the pin function
SetPinFunction_loop$:
	cmp r0, #9
	subhi r0, #10
	addhi r2, #4
	bhi SetPinFunction_loop$
	add r0, r0, lsl #1
	lsl r1, r0
	
	// Create mask
	mov r3, #7
	lsl r3, r0
	mvn r3, r3
	
	// Apply mask to preserve the states of the other pins
	ldr r0, [r2]
	and r3, r0
	orr r1, r3
	
	// Update pin
	str r1, [r2]
	
	pop {pc}


//   INPUT:	r0:pin < 54, r1:value (1bit)
//  OUTPUT:	none
// PURPOSE:	sets pin r0 to value r1
// CHANGES:	r0: pin % 32
//			r2: 0x2020000(0|4)
//			r3: 0x202000((1C|20)|2(8|C))
.global SetPinOutput
SetPinOutput:
	// Exit if invalid inputs
	cmp r0, #53
	cmpls r1, #1
	bhi Error
	
	push {lr}
	
	ldr r2, =0x20200000			// GPIO address
	
	// Get the address (either 0x20200000 or 0x20200004)
	lsr r3, r0, #5
	lsl r3, #2
	add r2, r3
	
	// Apply mask to preserve the states of the other pins
	and r0, #31
	mov r3, #1
	lsl r3, r0
	
	// Update pin
	teq r1, #0
	streq r3, [r2, #40]			// Off
	strne r3, [r2, #28]			// On
	
	pop {pc}
