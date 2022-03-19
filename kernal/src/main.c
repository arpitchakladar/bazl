#include "utils/bool.h"
#include "utils/int.h"
#include "utils/str.h"
#include "io/cli.h"
#include "mem/dyn.h"
#include "io/disk.h"
#include "io/disk/fs.h"

void main() {
	cli_write("Hello From Bazl!\r\n");
	uintptr_t user_name_max_len = 128;
	char *user_name;
	file_create("Username.txt", user_name_max_len);
	file_read("Username.txt", (uint8_t **) &user_name);
	if (user_name[0] == '\0') {
		cli_write("Enter your user name : ");
		cli_read(user_name, '\r', user_name_max_len);
		cli_write("\r\n");
		file_write("Username.txt", user_name, user_name_max_len);
	}
	cli_write("Hi, ");
	cli_write(user_name);
	cli_write("!\r\n");
	dyn_dealloc(user_name);
}
