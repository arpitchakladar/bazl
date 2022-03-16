#include "utils/bool.h"
#include "utils/int.h"
#include "utils/str.h"
#include "io/cli.h"
#include "mem/dyn.h"
#include "io/disk.h"

void main() {
	cli_write("Hello From Bazl!\r\n");
	uintptr_t name_buf_len = 120;
	char *name = dyn_alloc(name_buf_len);
	disk_read_buf(name, 21, name_buf_len);
	if (name[0] == '\0') {
		cli_write("Enter your name : ");
		cli_read(name, '\r', name_buf_len);
		cli_write("\r\n");
	}
	cli_write("Hi, ");
	cli_write(name);
	cli_write("!\r\n");
	disk_write_buf(name, 21, name_buf_len);
	char *num_str = dyn_alloc(6);
	while (true) {
		for (uint8_t i = 0; i < 6; i++)
			num_str[i] = 0;

		cli_write("Add ");
		cli_read(num_str, ' ', 6);
		int16_t num1 = str_to_int(num_str, str_len(num_str));
		cli_write(" + ");
		cli_read(num_str, '\r', 6);
		int16_t num2 = str_to_int(num_str, str_len(num_str));
		cli_write(" = ");
		cli_write_int(num1 + num2);
		cli_write(".\r\n");
	}
	dyn_dealloc(num_str);
}
