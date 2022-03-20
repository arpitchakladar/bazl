#include "utils/bool.h"
#include "utils/int.h"
#include "utils/str.h"
#include "io/cli.h"
#include "mem/dyn.h"
#include "io/disk.h"
#include "io/disk/fs.h"

const uintptr_t USER_NAME_MAX_LENGTH = 128;

void main() {
	cli_write("Hello From Bazl!\r\n");
	char *user_name;
	file_read("Username.txt", (uint8_t **) &user_name);
	if (user_name[0] == '\0') {
		cli_write("Enter your user name : ");
		cli_read(user_name, '\r', USER_NAME_MAX_LENGTH);
		cli_write("\r\n");
		file_write("Username.txt", user_name, USER_NAME_MAX_LENGTH);
	}
	cli_write("Hi, ");
	cli_write(user_name);
	cli_write("!\r\n");
	dyn_dealloc(user_name);
}
