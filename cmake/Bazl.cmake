set(bazl_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl")

add_custom_target(bazl
	ALL
	DEPENDS kernel boot-loader
	COMMAND cat $<TARGET_FILE:boot-loader> $<TARGET_FILE:kernel> > ${bazl_TARGET_FILE} && truncate -s ${KERNEL_SIZE_KB}k ${bazl_TARGET_FILE}
	VERBATIM)
