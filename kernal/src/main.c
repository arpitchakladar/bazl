#include "utils/bool.h"
#include "utils/int.h"
#include "utils/string.h"
#include "io/cli.h"
#include "memory/dyn.h"

void main() {
	cli_write("Hello From Bazl!\r\n");
	cli_write("Enter your name : ");
	char *name = memory_alloc(128);
	cli_read(name, '\r', 128);
	cli_write("\r\nHi, ");
	cli_write(name);
	cli_write("!\r\n");
	memory_dealloc(name);
	char *number_string = memory_alloc(128);
	while (true) {
		cli_write("Add ");
		cli_read(number_string, ' ', 128);
		int16_t number1 = string_to_int(number_string, string_length(number_string));
		cli_write(" + ");
		cli_read(number_string, '\r', 128);
		int16_t number2 = string_to_int(number_string, string_length(number_string));
		cli_write(" = ");
		cli_write_int(number1 + number2);
		cli_write(".\r\n");
	}
	memory_dealloc(number_string);
}
