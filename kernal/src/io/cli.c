#include "io/cli.h"
#include "core/types.h"
#include "memory/dynamic.h"

void cli_write_int(int16_t integer) {
	uint8_t digit_count = 0;
	{ // Calculate the number of digits
		int16_t abs_integer = (integer < 0) ? (-integer) : integer;
		do {
			abs_integer /= 10;
			digit_count ++;
		} while (abs_integer > 0);
	}

	char *number_string = memory_allocate(digit_count + 2);
	char *digits_string = number_string;

	if (integer < 0) {
		number_string[0] = '-';
		integer = -integer;
		digits_string = number_string + 1;
	}

	digits_string[digit_count] = '\0';
	for (uint8_t i = 1; i <= digit_count; i++) {
		digits_string[digit_count - i] = (integer % 10) + '0';
		integer /= 10;
	}

	cli_write(number_string);
	memory_deallocate(number_string);
}
