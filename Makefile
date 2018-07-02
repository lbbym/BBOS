ARMGNU ?= aarch64-linux-gnu

COPS = -Wall -nostdlib -nostarfiles -ffreestanding -Iinclude -mgeneral-regs-only
ASMOPS = -Iinclude
# -wall  Show all warnings.
# -nostdlib Don't use the C standard library. 
# -nostarfiles Don't use standard startup files.
# -ffreestanding freestanding environment.
# -Iinclude Search for header files in the include folder.
# -mgeneral-regs-only Use only general-purpose registers.

BUILD_DIR = build
SRC_DIR = src

all: kernel8.img

clean:
	rm -rf $(BUILD_DIR) *.img

$(BUILD_DIR)/%_c.o: $(SRC_DIR)/%.c
	mkdir -p $(@D)
	$(ARMGNU)-gcc $(COPS) -MMD -c $< -o $@

$(BUILD_DIR)/%_s.o: $(SRC_DIR)/%.S
	$(ARMGNU)-gcc $(ASMOPS) -MMD -c $< -o $@

C_FILES = $(wildcard $(SRC_DIR)/*.c)
ASM_FILES = $(wildcard $(SRC_DIR)/*.S)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%_c.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%_s.o)

DEP_FILES = $(OBJ_FILES:%.o=%.d)
-include $(DEP_FILES)

kernel8.img: $(SRC_DIR)/linker.ld $(OBJ_FILES)
	$(ARMGNU)-ld -T $(SRC_DIR)/linker.ld -o kernel8.elf  $(OBJ_FILES)
	$(ARMGNU)-objcopy kernel8.elf -O binary kernel8.img