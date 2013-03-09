# makefile

ARMGNU ?= arm-none-eabi

BUILD = Destination/

SOURCE = Source/

TARGET = kernel.img

LIST = list.txt

MAP = map.txt

LINKER = linker.ld

OBJECTS := $(patsubst $(SOURCE)%.s,$(BUILD)%.o,$(wildcard $(SOURCE)*.s))


all: $(TARGET) $(LIST)


rebuild: all
	
$(LIST) : $(BUILD)output.elf
	$(ARMGNU)-objdump -d $(BUILD)output.elf > $(LIST)
	
$(TARGET) : $(BUILD)output.elf
	$(ARMGNU)-objcopy $(BUILD)output.elf -O binary $(TARGET) 
	
$(BUILD)output.elf : $(OBJECTS) $(LINKER)
	$(ARMGNU)-ld --no-undefined $(OBJECTS) -Map $(MAP) -o $(BUILD)output.elf -T $(LINKER)
	
$(BUILD)%.o: $(SOURCE)%.s
	$(ARMGNU)-as -I $(SOURCE) $< -o $@


clean :
	-rm -f $(BUILD)*.o
	-rm -f $(BUILD)output.elf
	-rm -f $(TARGET)
	-rm -f $(LIST)
	-rm -f $(MAP)
