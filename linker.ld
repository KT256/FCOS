SECTIONS {
	.init 0x0000 : {
		*(.init)
	}
	
	.text 0x8000 : {
		*(.text)
	}
	
	.data : {
		*(.data)
	}
}
