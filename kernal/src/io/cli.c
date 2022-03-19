#include "io/cli.h"

#include "utils/int.h"
#include "mem/dyn.h"

void cli_write_int(int16_t int_num) {
	uint8_t digit_count = 0;
	{ // Calculate the number of digits in int_num
		int16_t abs_int_num = (int_num < 0) ? (-int_num) : int_num;
		do {
			abs_int_num /= 10;
			digit_count ++;
		} while (abs_int_num > 0);
	}

	char *int_num_str = dyn_alloc(digit_count + 2);
	char *digit_str = int_num_str;

	if (int_num < 0) {
		int_num_str[0] = '-';
		int_num = -int_num;
		digit_str = int_num_str + sizeof(char);
	}

	digit_str[digit_count] = '\0';
	for (uint8_t i = 1; i <= digit_count; i++) {
		digit_str[digit_count - i] = (int_num % 10) + '0';
		int_num /= 10;
	}

	cli_write(int_num_str);
	dyn_dealloc(int_num_str);
}
