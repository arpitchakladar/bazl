set(bazl_test_image_TARGET_FILE "${CMAKE_CURRENT_BINARY_DIR}/bazl-test.img")

add_custom_target(bazl_test_image
		ALL
		DEPENDS bazl
		COMMAND cat ${bazl_TARGET_FILE} > ${bazl_test_image_TARGET_FILE} && truncate -s 1m ${bazl_test_image_TARGET_FILE}
		VERBATIM)
