void main() {
	for (int i = 0; i < 26; i++) {
		*(char*)(0xb8000 + i * 2) = 'A' + (char) i;
		*(char*)(0xb8001 + i * 2) = 0x0f;
	}
	return;
}
