#include "io/cli.h"
#include "memory/dynamic.h"

void main() {
	cli_write("Hello From Bazl!\r\n");
	cli_write("Enter your name : ");
	char *name_buffer = memory_allocate(128);
	cli_read(name_buffer, 128);
	cli_write("Hi, ");
	cli_write(name_buffer);
	memory_deallocate(name_buffer);
	cli_write("!");
}
