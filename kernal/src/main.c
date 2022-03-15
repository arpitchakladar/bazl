#include "utils/bool.h"
#include "utils/int.h"
#include "utils/string.h"
#include "io/cli.h"
#include "memory/dyn.h"
#include "io/disk.h"

void main() {
	cli_write("Hello From Bazl!\r\n");
	char *name = memory_alloc(512);
	disk_read_sectors(name, 1, 0, 23, 0, BOOT_DRIVE_NUMBER);
	if (!string_length(name)) {
		cli_write("Enter your name : ");
		cli_read(name, '\r', 512);
		cli_write("\r\n");
	}
	cli_write("Hi, ");
	cli_write(name);
	cli_write("!\r\n");
	disk_write_sectors(name, 1, 0, 23, 0, BOOT_DRIVE_NUMBER);
	memory_dealloc(name);
	char *number_string = memory_alloc(6);
	while (true) {
		for (uint8_t i = 0; i < 6; i++)
			number_string[i] = 0;

		cli_write("Add ");
		cli_read(number_string, ' ', 6);
		int16_t number1 = string_to_int(number_string, string_length(number_string));
		cli_write(" + ");
		cli_read(number_string, '\r', 6);
		int16_t number2 = string_to_int(number_string, string_length(number_string));
		cli_write(" = ");
		cli_write_int(number1 + number2);
		cli_write(".\r\n");
	}
	memory_dealloc(number_string);
}
