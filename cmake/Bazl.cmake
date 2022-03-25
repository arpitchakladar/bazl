set(bazl_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl")

add_custom_target(bazl
	ALL
	DEPENDS kernal boot_loader
	COMMAND cat $<TARGET_FILE:boot_loader> $<TARGET_FILE:kernal> > ${bazl_TARGET_FILE} && truncate -s ${KERNAL_SIZE_KB}k ${bazl_TARGET_FILE}
	VERBATIM)
