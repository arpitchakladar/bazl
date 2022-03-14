#include "utils/string.h"
#include "utils/int.h"
#include "utils/bool.h"

bool string_equal(char *string1, char *string2) {
	uint16_t i = 0;
	while (true) {
		if (string1[i] == string2[i])
			if (string1[i] == '\0' && string2[i] == '\0')
				return true;

			else
				i++;

		else
			return false;
	}
}

uint16_t string_length(char *string) {
	uint16_t i = 0;
	for (; string[i] != '\0'; i++)
		continue;
	return i;
}

int16_t string_to_int(char *string, uint8_t length) {
	int16_t result = 0;
	int16_t pos_value = 1;

	for (uint8_t i = 1; i <= length; i++) {
		char digit = string[length - i];
		if (digit >= '0' && digit <= '9')
			result += pos_value * (digit - '0');
		else if (digit == '-') {
			result = -result;
			break;
		} else
			break;
		pos_value *= 10;
	}

	return result;
}
