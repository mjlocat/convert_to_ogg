INSTALL_DIR=/usr/local/bin

${INSTALL_DIR}:
	mkdir -p "${INSTALL_DIR}"

install: ${INSTALL_DIR}
	cp convert_to_ogg.sh "${INSTALL_DIR}/convert_to_ogg"
	chmod 755 "${INSTALL_DIR}/convert_to_ogg"

uninstall:
	rm -f "${INSTALL_DIR}/convert_to_ogg"
