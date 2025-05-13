CROSS = riscv64-linux-gnu-
CC = $(CROSS)gcc
AS = $(CROSS)as
LD = $(CROSS)ld
OBJCOPY = $(CROSS)objcopy
CFLAGS = -O -Wall -fno-pic -march=rv64g -mabi=lp64d -nostdlib -nostartfiles

all: kernel.bin

kernel.elf: entry.S main.c page.c proc.c trap.c kernelvec.S printf.c mm/vm.c mm/vm_test.c switch.S syscall.c linker.ld
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c entry.S -o entry.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c page.c -o page.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c proc.c -o proc.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c trap.c -o trap.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c main.c -o main.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c kernelvec.S -o kernelvec.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c printf.c -o printf.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c switch.S -o switch.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c syscall.S -o syscall.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c mm/vm.c -o mm/vm.o
	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c mm/vm_test.c -o mm/vm_test.o
	$(LD) -T linker.ld entry.o main.o page.o proc.o trap.o kernelvec.o printf.o mm/vm.o mm/vm_test.o switch.o syscall.o -o kernel.elf

# kernel.elf: entry.S main.c page.c proc.c trap.c kernelvec.S printf.c mm/vm.c linker.ld
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c entry.S -o entry.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c page.c -o page.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c proc.c -o proc.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c trap.c -o trap.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c main.c -o main.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c kernelvec.S -o kernelvec.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c printf.c -o printf.o
# 	$(CC) $(CFLAGS) -mcmodel=medany -ffreestanding -c mm/vm.c -o mm/vm.o
# 	$(LD) -T linker.ld entry.o main.o page.o proc.o trap.o kernelvec.o printf.o mm/vm.o -o kernel.elf

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

run: kernel.bin
	qemu-system-riscv64 -machine virt -bios none -kernel kernel.bin -nographic

clean:
	rm -f *.o *.elf *.bin
	rm -f ./mm/*.o