#include "utils/str.h"
#include "utils/int.h"
#include "utils/bool.h"

bool str_equal(char *str1, char *str2) {
	uint16_t i = 0;
	while (true) {
		if (str1[i] == str2[i])
			if (str1[i] == '\0' && str2[i] == '\0')
				return true;

			else
				i++;

		else
			return false;
	}
}

uintptr_t str_len(char *str) {
	uint16_t i = 0;
	for (; str[i] != '\0'; i++)
		continue;
	return i;
}

int16_t str_to_int(char *str, uint8_t len) {
	int16_t res = 0;
	int16_t pos_value = 1;

	for (uint8_t i = 1; i <= len; i++) {
		char digit = str[len - i];
		if (digit >= '0' && digit <= '9')
			res += pos_value * (digit - '0');
		else if (digit == '-') {
			res = -res;
			break;
		} else
			break;
		pos_value *= 10;
	}

	return res;
}
